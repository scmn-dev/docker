### image name: smcr/secman ###

FROM debian:latest

### begin ###

### variables ###
ARG UPD="apt-get update"
ARG UPD_s="sudo $UPD"
ARG INS="apt-get install"
ARG INS_s="sudo $INS"
ENV PKGS="zip unzip multitail curl lsof wget ssl-cert asciidoctor apt-transport-https ca-certificates gnupg-agent bash-completion build-essential htop jq software-properties-common less llvm locales man-db nano vim ruby-full"
ENV BUILDS="build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev libbz2-dev"

RUN $UPD && $INS -y $PKGS && $UPD && \
    locale-gen en_US.UTF-8 && \
    mkdir /var/lib/apt/abdcodedoc-marks && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* && \
    $UPD

ENV LANG=en_US.UTF-8

### git ###
RUN $INS -y git && \
    rm -rf /var/lib/apt/lists/* && \
    $UPD

### sudo ###
RUN $UPD && $INS -y sudo && \
    adduser --disabled-password --gecos '' secman_yo && \
    adduser secman_yo sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

### nodejs & npm ###
RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh && \
    sudo bash nodesource_setup.sh && \
    $INS_s nodejs build-essential -y && \
    sudo rm -rf nodesource_setup.sh && \
    $UPD_s

ENV HOME="/home/secman_yo"
WORKDIR $HOME
USER secman_yo

### secman ###
RUN curl -fsSL https://unix.secman.dev | bash

### zsh ###
ENV src=".zshrc"

RUN $INS_s zsh -y
RUN zsh && \
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
    $UPD_s && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

### rm old ~/.zshrc ###
RUN sudo rm -rf $src

### wget new files ###
RUN wget https://docker.secman.dev/.zshrc
RUN wget https://docker.secman.dev/README

CMD /bin/bash -c "cat README && zsh"

### end ###
