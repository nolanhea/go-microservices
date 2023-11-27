FROM golang:1.21-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app
RUN ["go", "mod", "download"]
RUN CGO_ENABLED=0 go build -o authApp ./cmd/api

RUN chmod +x /app/authApp

FROM alpine:latest
RUN mkdir /app
COPY --from=builder /app/authApp /app
CMD ["/app/authApp"]