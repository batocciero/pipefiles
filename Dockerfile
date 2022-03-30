FROM ubuntu:20.04

RUN apt-get update \
  && apt-get upgrade -y \
  && dpkg --configure -a \
  && apt-get install \
  git \
  sudo \
  keychain \
  wget \
  build-essential vim \
  curl \
  file \
  ruby-full \
  locales --no-install-recommends -y &&  \
  rm -rf /var/lib/apt/lists/*

RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN useradd -m -s /bin/bash linuxbrew && \
  echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER linuxbrew
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

USER root
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

USER linuxbrew
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
RUN brew install gcc tmux nvim

WORKDIR /home/test/auto
