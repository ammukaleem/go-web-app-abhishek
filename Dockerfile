# Use official Golang image as build stage
FROM golang:1.21 AS builder

# Set working directory inside container
WORKDIR /app

# Copy Go module files and download dependencies
COPY go.mod .
RUN go mod download

# Copy the source code
COPY . .

# Build the Go application
RUN go build -o main .

# Use a minimal base image for deployment
FROM gcr.io/distroless/base

# Copy the built binary from the builder stage
COPY --from=builder /app/main .
COPY --from=builder /app/static ./static 

# Expose the application port
EXPOSE 8080

# Run the Go application
CMD ["./main"]
