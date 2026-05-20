package main

import (
	"encoding/binary"
	"errors"
)

// C->H message types
const (
	kC2hList  = 0x01
	kC2hHello = 0x02
	kC2hState = 0x03
	kC2hAudio = 0x04
)

// H->C message types
const (
	kH2cRoomList   = 0x10
	kH2cWelcome    = 0x11
	kH2cPeerJoined = 0x12
	kH2cPeerLeft   = 0x13
	kH2cPeerState  = 0x14
	kH2cPeerAudio  = 0x15
	kH2cError      = 0x16
)

const (
	kHeaderBytes       = 3
	kMaxPlayersPerRoom = 8
)

// HubMessage represents a decoded message from the wire.
type HubMessage struct {
	Type    byte
	Payload []byte
}

// EncodeMessage wraps the payload in the 3-byte protocol header.
func EncodeMessage(msgType byte, payload []byte) []byte {
	buf := make([]byte, kHeaderBytes+len(payload))
	buf[0] = msgType
	binary.BigEndian.PutUint16(buf[1:3], uint16(len(payload)))
	copy(buf[kHeaderBytes:], payload)
	return buf
}

// EncodeError creates an error message.
func EncodeError(msg string) []byte {
	return EncodeMessage(kH2cError, []byte(msg))
}

// ParseHeader returns the length of the payload from a 3-byte header.
// It returns an error if the header is too short.
func ParseHeader(header []byte) (uint16, error) {
	if len(header) < kHeaderBytes {
		return 0, errors.New("header too short")
	}
	return binary.BigEndian.Uint16(header[1:3]), nil
}
