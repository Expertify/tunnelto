# Build stage
FROM clux/muslrust:stable AS builder

# Set the working directory
WORKDIR /app

# Copy the Rust source code
COPY . .

# Build the Rust app
RUN cargo build --bin tunnelto_server --release

# Final stage
FROM alpine:latest

# Copy the compiled binary from the build stage to the final stage
COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/tunnelto_server /tunnelto_server

# client svc
EXPOSE 8080
# ctrl svc
EXPOSE 5000
# net svc
EXPOSE 10002

ENTRYPOINT ["/tunnelto_server"]
