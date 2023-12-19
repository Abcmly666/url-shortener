FROM golang:1.20 AS builder
ENV CGO_ENABLED 0
ENV GOOS linux
ENV GOPROXY https:///goproxy.cn, direct
WORKDIR /tem
COPY . .
RUN go mod download
RUN go build -o main
FROM debian:stable-slim
COPY --from=builder /tem/main .
EXPOSE 80
CMD ["./main"]
