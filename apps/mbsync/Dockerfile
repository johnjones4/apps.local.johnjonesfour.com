FROM debian:buster

RUN apt-get update && apt-get install -y \
  isync \
  openssl

COPY run.sh /run.sh

VOLUME [ "/config", "/data" ]

CMD [ "/run.sh" ]
