FROM golang:1.26-alpine AS builder

RUN apk add --no-cache git

WORKDIR /src
COPY CLIProxyAPI/ .
RUN go build -o /cli-proxy-api ./cmd/server/

FROM alpine:3.21

RUN apk add --no-cache ca-certificates tzdata
COPY --from=builder /cli-proxy-api /usr/local/bin/cli-proxy-api
COPY config.yaml /etc/cli-proxy-api/config.yaml

EXPOSE 8787

ENTRYPOINT ["cli-proxy-api", "--config", "/etc/cli-proxy-api/config.yaml"]
