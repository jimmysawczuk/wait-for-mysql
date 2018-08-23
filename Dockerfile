FROM golang:1.10.3 AS builder
WORKDIR /go/src/github.com/jimmysawczuk/wait-for-mysql
COPY . .
RUN CGO_ENABLED=0 go install ./...

FROM alpine
WORKDIR /usr/bin
COPY --from=builder /go/bin/wait-for-mysql /usr/bin/wait-for-mysql
ENTRYPOINT ["wait-for-mysql"]
