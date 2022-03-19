FROM ubuntu

RUN apt-get update \
  && apt-get upgrade -y \
  && dpkg --configure -a \
  && apt-get install \
  git \
  sudo \
  keychain \
  wget \
  build-essential vim -y
WORKDIR /home/test/auto
