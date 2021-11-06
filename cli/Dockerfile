### image name: smcr/secman-cli ###

FROM debian

### begin ###

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y npm nodejs
RUN apt-get install -y curl sudo wget

# run `make pull_secman` before this step
RUN npm i -g secman
RUN secman init

ENTRYPOINT ["secman"]

### end ###
