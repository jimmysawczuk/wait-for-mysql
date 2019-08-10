FROM golang:1.12 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -o wait-for-mysql .

FROM alpine
WORKDIR /usr/bin
COPY --from=builder /app/wait-for-mysql /usr/bin/wait-for-mysql
ENTRYPOINT ["wait-for-mysql"]
