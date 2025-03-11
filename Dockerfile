# Use official Golang image as build stage
FROM golang:1.21 AS builder

# Set working directory inside container
WORKDIR /app

# Copy Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code
COPY . .

# Build the Go application
RUN go build -o go-web-app

# Set working directory inside the minimal image
WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=builder /app/go-web-app .

# Expose the application port
EXPOSE 8080

# Run the Go application
CMD ["./go-web-app"]
