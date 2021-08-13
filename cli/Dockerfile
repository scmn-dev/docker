### image name: smcr/secman-cli ###

FROM alpine:latest

### begin ###

RUN apk update && apk upgrade && \
  apk add --no-cache ca-certificates wget

RUN wget https://docker.secman.dev/secman
RUN mv secman /usr/local/bin

ENTRYPOINT ["/usr/local/bin/secman"]

### end ###
