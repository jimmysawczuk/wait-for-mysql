FROM golang:1.17 AS builder
LABEL org.opencontainers.image.source = "https://github.com/jimmysawczuk/wait-for-mysql"
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -a -o wait-for-mysql \
	-ldflags "-s -d" \
	.

FROM alpine
WORKDIR /usr/bin
COPY --from=builder /app/wait-for-mysql /usr/bin/wait-for-mysql
ENTRYPOINT ["wait-for-mysql"]
