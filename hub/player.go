package main

import (
	"net"
	"sync"
)

// Player represents a connected client in the hub.
type Player struct {
	ID       byte
	Name     string
	RoomCode string
	Conn     net.Conn
	mu       sync.Mutex // Ensures thread-safe writes to the socket
}

// Send writes data to the player's socket thread-safely.
// We swallow write errors here similar to the Dart implementation, 
// as the read handler loop will eventually detect the disconnect and clean up.
func (p *Player) Send(data []byte) {
	p.mu.Lock()
	defer p.mu.Unlock()
	_, _ = p.Conn.Write(data)
}
