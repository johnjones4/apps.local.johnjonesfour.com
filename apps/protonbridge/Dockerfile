from ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install -y \
  make \
  libsecret-1-dev \
  pkg-config \
  gcc \
  pass \
  wget

WORKDIR /usr/src

RUN wget https://golang.org/dl/go1.16.5.linux-$(dpkg --print-architecture).tar.gz
RUN tar zxvf go1.16.5.linux-$(dpkg --print-architecture).tar.gz

WORKDIR /usr/src/app

RUN wget https://github.com/ProtonMail/proton-bridge/archive/refs/tags/v1.8.7.tar.gz
RUN tar zxvf v1.8.7.tar.gz

WORKDIR /usr/src/app/proton-bridge-1.8.7

RUN PATH=/usr/src/go/bin:$PATH make install-dev-dependencies
RUN PATH=/usr/src/go/bin:$PATH make build-nogui

VOLUME [ "/root/.config", "/root/.gnupg", "/root/.password-store"]

CMD [ "./proton-bridge", "--noninteractive" ]
