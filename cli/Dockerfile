### image name: smcr/secman-cli ###

FROM debian

### begin ###

RUN apt-get update -y && apt-get upgrade -y

# run `make pull_secman` before this step
COPY secman /bin/secman

ENTRYPOINT ["/bin/secman"]

### end ###
