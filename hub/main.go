package main

import (
	"flag"
	"log"
	"os"
	"strconv"
)

func main() {
	// Let environment variable PORT override default if set
	portStr := os.Getenv("PORT")
	defaultPort := kDefaultHubPort
	if portStr != "" {
		if p, err := strconv.Atoi(portStr); err == nil {
			defaultPort = p
		}
	}

	// Also allow flag -port to override
	portPtr := flag.Int("port", defaultPort, "TCP port to listen on for hub connections")
	flag.Parse()

	server := NewServer(*portPtr)
	log.Printf("Starting HorizonProx standalone hub on port %d...", *portPtr)
	if err := server.Start(); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
