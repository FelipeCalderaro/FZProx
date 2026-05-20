package main

import (
	"fmt"
	"io"
	"log"
	"net"
	"sync"
	"time"
)

// Server handles the TCP relay connections.
type Server struct {
	port    int
	rooms   map[string]*Room
	mu      sync.Mutex // Protects rooms map
	nextID  byte
	idMu    sync.Mutex
	running bool
}

// NewServer creates a new Hub Server.
func NewServer(port int) *Server {
	return &Server{
		port:   port,
		rooms:  make(map[string]*Room),
		nextID: 1,
	}
}

// Start begins listening on the port.
func (s *Server) Start() error {
	addr := fmt.Sprintf(":%d", s.port)
	listener, err := net.Listen("tcp", addr)
	if err != nil {
		return err
	}
	s.running = true
	log.Printf("Hub Server listening on %s\n", addr)

	for s.running {
		conn, err := listener.Accept()
		if err != nil {
			if !s.running {
				break
			}
			log.Printf("Accept error: %v\n", err)
			continue
		}
		// Try setting TCP NoDelay (disabling Nagle's algorithm)
		if tcpConn, ok := conn.(*net.TCPConn); ok {
			_ = tcpConn.SetNoDelay(true)
		}
		go s.handleClient(conn)
	}
	return nil
}

func (s *Server) handleClient(conn net.Conn) {
	var player *Player
	joined := make(chan struct{})

	// 30 seconds join timeout
	go func() {
		select {
		case <-time.After(30 * time.Second):
			if player == nil {
				conn.Close()
			}
		case <-joined:
			// joined successfully in time
		}
	}()

	defer func() {
		if player != nil {
			s.deregister(player)
		}
		conn.Close()
	}()

	buf := make([]byte, 4096)
	var stream []byte

	for {
		n, err := conn.Read(buf)
		if err != nil {
			if err != io.EOF {
				log.Printf("Read error: %v\n", err)
			}
			break
		}
		stream = append(stream, buf[:n]...)

		for {
			if len(stream) < kHeaderBytes {
				break // Wait for more data to read header
			}

			payloadLen, err := ParseHeader(stream)
			if err != nil {
				break
			}

			totalLen := kHeaderBytes + int(payloadLen)
			if len(stream) < totalLen {
				break // Wait for rest of payload
			}

			msgType := stream[0]
			payload := stream[kHeaderBytes:totalLen]

			msg := HubMessage{
				Type:    msgType,
				Payload: payload,
			}

			if player == nil {
				// We haven't fully joined yet
				p, done := s.handlePreJoin(conn, msg)
				if p != nil {
					player = p
					close(joined)
				}
				if done {
					// We've processed the join (or failed), break inner loop to continue
				}
			} else {
				s.handleRelay(player, msg)
			}

			stream = stream[totalLen:]
		}
	}
}

func (s *Server) handlePreJoin(conn net.Conn, msg HubMessage) (*Player, bool) {
	switch msg.Type {
	case kC2hList:
		_, _ = conn.Write(s.buildRoomList())
		return nil, false

	case kC2hHello:
		if len(msg.Payload) < 4 {
			_, _ = conn.Write(EncodeError("Invalid room code"))
			return nil, true
		}
		roomCode := string(msg.Payload[:4])
		username := string(msg.Payload[4:])

		s.mu.Lock()
		room, exists := s.rooms[roomCode]
		if !exists {
			room = NewRoom(roomCode)
			s.rooms[roomCode] = room
		}
		s.mu.Unlock()

		if room.Count() >= kMaxPlayersPerRoom {
			_, _ = conn.Write(EncodeError(fmt.Sprintf("Room %s is full", roomCode)))
			return nil, true
		}

		id := s.allocID()
		player := &Player{
			ID:       id,
			Name:     username,
			RoomCode: roomCode,
			Conn:     conn,
		}
		room.Add(player)

		s.sendWelcome(conn, player, room)
		room.BroadcastPeerJoined(player)
		log.Printf("Player %d (%s) joined room %s\n", player.ID, player.Name, room.Code)
		return player, true
	}
	return nil, false
}

func (s *Server) handleRelay(player *Player, msg HubMessage) {
	s.mu.Lock()
	room, exists := s.rooms[player.RoomCode]
	s.mu.Unlock()

	if !exists {
		return
	}

	switch msg.Type {
	case kC2hAudio:
		payload := make([]byte, 1+len(msg.Payload))
		payload[0] = player.ID
		copy(payload[1:], msg.Payload)
		room.Broadcast(EncodeMessage(kH2cPeerAudio, payload), player.ID)

	case kC2hState:
		payload := make([]byte, 1+len(msg.Payload))
		payload[0] = player.ID
		copy(payload[1:], msg.Payload)
		room.Broadcast(EncodeMessage(kH2cPeerState, payload), player.ID)

	case kC2hList:
		player.Send(s.buildRoomList())
	}
}

func (s *Server) deregister(player *Player) {
	s.mu.Lock()
	room, exists := s.rooms[player.RoomCode]
	s.mu.Unlock()

	if !exists {
		return
	}

	room.Remove(player.ID)
	room.BroadcastPeerLeft(player.ID)
	log.Printf("Player %d (%s) left room %s\n", player.ID, player.Name, room.Code)

	s.mu.Lock()
	if room.IsEmpty() {
		delete(s.rooms, player.RoomCode)
		log.Printf("Room %s destroyed\n", room.Code)
	}
	s.mu.Unlock()
}

func (s *Server) buildRoomList() []byte {
	s.mu.Lock()
	defer s.mu.Unlock()

	payload := make([]byte, 1+len(s.rooms)*5)
	payload[0] = byte(len(s.rooms))
	
	i := 0
	for code, room := range s.rooms {
		offset := 1 + i*5
		
		// Ensure room code is exactly 4 chars
		codeBytes := []byte(code)
		for j := 0; j < 4; j++ {
			if j < len(codeBytes) {
				payload[offset+j] = codeBytes[j]
			} else {
				payload[offset+j] = ' '
			}
		}
		payload[offset+4] = byte(room.Count())
		i++
	}
	return EncodeMessage(kH2cRoomList, payload)
}

func (s *Server) sendWelcome(conn net.Conn, self *Player, room *Room) {
	peers := room.Players()
	var otherPeers []*Player
	for _, p := range peers {
		if p.ID != self.ID {
			otherPeers = append(otherPeers, p)
		}
	}

	payloadLen := 1 + 4 + 1 // selfId + code(4B) + nPeers
	for _, p := range otherPeers {
		payloadLen += 2 + len(p.Name)
	}

	payload := make([]byte, payloadLen)
	off := 0

	payload[off] = self.ID
	off++

	codeBytes := []byte(room.Code)
	for j := 0; j < 4; j++ {
		if j < len(codeBytes) {
			payload[off] = codeBytes[j]
		} else {
			payload[off] = ' '
		}
		off++
	}

	payload[off] = byte(len(otherPeers))
	off++

	for _, p := range otherPeers {
		payload[off] = p.ID
		off++
		
		nameBytes := []byte(p.Name)
		payload[off] = byte(len(nameBytes))
		off++
		
		copy(payload[off:], nameBytes)
		off += len(nameBytes)
	}

	_, _ = conn.Write(EncodeMessage(kH2cWelcome, payload))
}

func (s *Server) allocID() byte {
	s.idMu.Lock()
	defer s.idMu.Unlock()
	id := s.nextID
	s.nextID = (s.nextID % 254) + 1
	return id
}
