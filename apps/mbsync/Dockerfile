FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  make \
  gcc \
  wget \
  openssl \
  libssl-dev \
  libsecret-1-dev \
  pkg-config \
  pass \
  git

WORKDIR /src

RUN wget https://golang.org/dl/go1.16.5.linux-$(dpkg --print-architecture).tar.gz
RUN tar zxvf go1.16.5.linux-$(dpkg --print-architecture).tar.gz

RUN wget https://downloads.sourceforge.net/project/isync/isync/1.4.1/isync-1.4.1.tar.gz
RUN tar zxvf isync-1.4.1.tar.gz

RUN wget https://github.com/ProtonMail/proton-bridge/archive/refs/tags/v1.8.7.tar.gz
RUN tar zxvf v1.8.7.tar.gz

WORKDIR /src/isync-1.4.1
RUN ./configure && make && make install

WORKDIR /src/proton-bridge-1.8.7
RUN PATH=/src/go/bin:$PATH make install-dev-dependencies
RUN PATH=/src/go/bin:$PATH make build-nogui

WORKDIR /src/app

COPY run.sh /run.sh

VOLUME [ "/config", "/data", "/root/.config", "/root/.gnupg", "/root/.password-store" ]

CMD [ "/run.sh" ]
