package main

import (
	"sync"
)

// Room manages all players in a single session.
type Room struct {
	Code    string
	players map[byte]*Player
	mu      sync.RWMutex
}

// NewRoom creates a new Room instance.
func NewRoom(code string) *Room {
	return &Room{
		Code:    code,
		players: make(map[byte]*Player),
	}
}

// IsEmpty returns true if there are no players in the room.
func (r *Room) IsEmpty() bool {
	r.mu.RLock()
	defer r.mu.RUnlock()
	return len(r.players) == 0
}

// Count returns the number of players in the room.
func (r *Room) Count() int {
	r.mu.RLock()
	defer r.mu.RUnlock()
	return len(r.players)
}

// Add adds a player to the room.
func (r *Room) Add(p *Player) {
	r.mu.Lock()
	defer r.mu.Unlock()
	r.players[p.ID] = p
}

// Remove removes a player from the room by their ID.
func (r *Room) Remove(playerID byte) {
	r.mu.Lock()
	defer r.mu.Unlock()
	delete(r.players, playerID)
}

// Broadcast sends msg to every player in the room except the one with excludeID.
func (r *Room) Broadcast(msg []byte, excludeID byte) {
	r.mu.RLock()
	defer r.mu.RUnlock()
	for _, p := range r.players {
		if p.ID != excludeID {
			// Broadcast asynchronously to prevent a slow connection from blocking the room lock
			// or other players' broadcasts.
			go p.Send(msg)
		}
	}
}

// BroadcastPeerLeft notifies other players that a peer has left.
func (r *Room) BroadcastPeerLeft(leftID byte) {
	payload := []byte{leftID}
	msg := EncodeMessage(kH2cPeerLeft, payload)
	r.Broadcast(msg, leftID)
}

// BroadcastPeerJoined notifies other players about a new peer.
func (r *Room) BroadcastPeerJoined(joined *Player) {
	nameBytes := []byte(joined.Name)
	payload := make([]byte, 2+len(nameBytes))
	payload[0] = joined.ID
	payload[1] = byte(len(nameBytes))
	copy(payload[2:], nameBytes)
	msg := EncodeMessage(kH2cPeerJoined, payload)
	r.Broadcast(msg, joined.ID)
}

// Players returns a snapshot of the players in the room.
func (r *Room) Players() []*Player {
	r.mu.RLock()
	defer r.mu.RUnlock()
	list := make([]*Player, 0, len(r.players))
	for _, p := range r.players {
		list = append(list, p)
	}
	return list
}
