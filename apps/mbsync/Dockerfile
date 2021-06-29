FROM debian:buster

RUN apt-get update && apt-get install -y \
  make \
  gcc \
  wget \
  openssl \
  libssl-dev

WORKDIR /src

RUN wget https://downloads.sourceforge.net/project/isync/isync/1.4.1/isync-1.4.1.tar.gz
RUN tar zxvf isync-1.4.1.tar.gz

WORKDIR /src/isync-1.4.1
RUN ./configure && make && make install

WORKDIR /src
RUN rm -rf isync-1.4.1

COPY run.sh /run.sh

VOLUME [ "/config", "/data" ]

CMD [ "/run.sh" ]
