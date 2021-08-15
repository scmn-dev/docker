### image name: smcr/secman-cli ###

FROM debian

### begin ###

RUN apt-get update && apt-get upgrade

# run `make pull_secman` before this step
COPY ../secman /bin/secman

ENTRYPOINT ["/bin/secman"]

### end ###
