from ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install -y \
  make \
  libsecret-1-dev \
  pkg-config \
  gcc \
  pass \
  wget \
  git

WORKDIR /usr/src

RUN wget https://golang.org/dl/go1.16.5.linux-$(dpkg --print-architecture).tar.gz
RUN tar zxvf go1.16.5.linux-$(dpkg --print-architecture).tar.gz

WORKDIR /usr/src/app

RUN git clone https://github.com/johnjones4/proton-bridge.git

WORKDIR /usr/src/app/proton-bridge

RUN PATH=/usr/src/go/bin:$PATH make install-dev-dependencies
RUN PATH=/usr/src/go/bin:$PATH make build-nogui

VOLUME [ "/root/.config", "/root/.gnupg", "/root/.password-store"]

CMD [ "./proton-bridge", "--noninteractive" ]
