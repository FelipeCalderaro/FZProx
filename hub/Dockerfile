# Build stage
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Copy modules
COPY go.mod ./

# Copy source code
COPY *.go ./

# Build the statically linked binary
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o fzprox-hub .

# Final stage - extremely lightweight
FROM alpine:latest

WORKDIR /app

# Add tzdata for timezone support
RUN apk --no-cache add tzdata

# Copy the binary from builder
COPY --from=builder /app/fzprox-hub .

# Expose default port
EXPOSE 9200

# Run the hub
ENTRYPOINT ["./fzprox-hub"]
