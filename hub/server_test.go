package main

import (
	"bytes"
	"encoding/binary"
	"net"
	"testing"
	"time"
)

func TestHubProtocol(t *testing.T) {
	// Start server on a high port for testing
	port := 9201
	server := NewServer(port)
	go func() {
		_ = server.Start()
	}()
	
	// Wait for server to start
	time.Sleep(100 * time.Millisecond)

	// Connect Client 1
	conn1, err := net.Dial("tcp", "127.0.0.1:9201")
	if err != nil {
		t.Fatalf("Failed to connect: %v", err)
	}
	defer conn1.Close()

	// Send HELLO for Client 1
	helloPayload := make([]byte, 4+4)
	copy(helloPayload[0:4], []byte("TEST"))
	copy(helloPayload[4:], []byte("User"))
	msg := EncodeMessage(kC2hHello, helloPayload)
	_, err = conn1.Write(msg)
	if err != nil {
		t.Fatalf("Failed to write HELLO: %v", err)
	}

	// Read WELCOME for Client 1
	welcomeBuf := make([]byte, 1024)
	n, err := conn1.Read(welcomeBuf)
	if err != nil {
		t.Fatalf("Failed to read WELCOME: %v", err)
	}

	if welcomeBuf[0] != kH2cWelcome {
		t.Errorf("Expected WELCOME (0x%02x), got 0x%02x", kH2cWelcome, welcomeBuf[0])
	}
	
	// Check the payload length to ensure it parsed
	welcomePayloadLen := binary.BigEndian.Uint16(welcomeBuf[1:3])
	if int(welcomePayloadLen) + 3 > n {
		t.Errorf("Read less bytes than expected for WELCOME")
	}

	// Connect Client 2
	conn2, err := net.Dial("tcp", "127.0.0.1:9201")
	if err != nil {
		t.Fatalf("Failed to connect conn2: %v", err)
	}
	defer conn2.Close()

	helloPayload2 := make([]byte, 4+5)
	copy(helloPayload2[0:4], []byte("TEST"))
	copy(helloPayload2[4:], []byte("Other"))
	msg2 := EncodeMessage(kC2hHello, helloPayload2)
	_, _ = conn2.Write(msg2)

	// Client 1 should receive PEER_JOINED
	joinedBuf := make([]byte, 1024)
	n, err = conn1.Read(joinedBuf)
	if err != nil {
		t.Fatalf("Failed to read PEER_JOINED: %v", err)
	}
	if joinedBuf[0] != kH2cPeerJoined {
		t.Errorf("Expected PEER_JOINED (0x%02x), got 0x%02x", kH2cPeerJoined, joinedBuf[0])
	}

	// Client 1 sends AUDIO
	audioMsg := EncodeMessage(kC2hAudio, []byte("fake_pcm_data"))
	_, _ = conn1.Write(audioMsg)

	// Client 2 should receive PEER_AUDIO
	// Note: conn2 might read WELCOME first, so we read twice
	audioBuf := make([]byte, 1024)
	conn2.SetReadDeadline(time.Now().Add(1 * time.Second))
	for {
		n, err = conn2.Read(audioBuf)
		if err != nil {
			t.Fatalf("Failed to read AUDIO: %v", err)
		}
		if audioBuf[0] == kH2cPeerAudio {
			// Found it
			if !bytes.Contains(audioBuf[3:n], []byte("fake_pcm_data")) {
				t.Errorf("Audio payload missing from PEER_AUDIO")
			}
			break
		}
	}
	
	server.running = false
}
