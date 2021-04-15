FROM debian:latest

# vars
ARG UPD="apt-get update"
ARG UPD_s="sudo $UPD"
ARG INS="apt-get install"
ARG INS_s="sudo $INS"
ARG APT_REPO="add-apt-repository"
ARG APT_REPO_s="sudo $APT_REPO"
ARG GITHUB_URL="https://raw.githubusercontent.com"
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

### config git ###
RUN git config --global user.name secman_yo
RUN git config --global user.email yo@secman.vercel.app

# sudo
RUN $UPD && $INS -y sudo && \
    adduser --disabled-password --gecos '' smx && \
    adduser smx sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

### docker ###
USER root

RUN $UPD_s
RUN curl -o /var/lib/apt/abdcodedoc-marks/docker.gpg -fsSL https://download.docker.com/linux/debian/gpg && \
    sudo apt-key add /var/lib/apt/abdcodedoc-marks/docker.gpg && \
    $APT_REPO_s "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs)  stable" && \
    $UPD_s && \
    $INS_s -y docker-ce docker-ce-cli containerd.io docker-compose && \
    sudo cp /var/lib/dpkg/status /var/lib/apt/abdcodedoc-marks/tool-docker.status && \
    sudo apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* && \
    $UPD_s

ENV HOME="/home/smx"
WORKDIR $HOME
USER smx

### nodejs & npm ###
RUN curl -sL https://deb.nodesource.com/setup_15.x -o nodesource_setup.sh && \
    sudo bash nodesource_setup.sh && \
    $INS_s nodejs build-essential -y && \
    sudo rm -rf nodesource_setup.sh && \
    $UPD_s

### secman ###
RUN curl -fsSL https://secman-team.github.io/install.sh | bash

### zsh ###
ENV src=".zshrc"

RUN $INS_s zsh -y
RUN zsh && \
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
    $UPD_s && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# rm old files
RUN sudo rm -rf $src

# wget new files
RUN wget https://secman-team.github.io/docker/.zshrc

CMD /bin/bash -c "zsh"
