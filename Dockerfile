FROM alpine AS builder

RUN apk add curl ca-certificates
ENV KUBESEC_VERSION 0.9.2

RUN curl -sSL https://github.com/shyiko/kubesec/releases/download/${KUBESEC_VERSION}/kubesec-${KUBESEC_VERSION}-linux-amd64 \
    -o kubesec && chmod a+x kubesec

FROM busybox

COPY --from=builder kubesec /usr/local/bin/kubesec
COPY --from=builder /etc/ssl/certs /etc/ssl/certs