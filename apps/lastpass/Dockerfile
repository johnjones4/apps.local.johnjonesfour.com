FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  lastpass-cli

VOLUME [ "/config", "/data" ]

ENV LPASS_HOME=/config

WORKDIR /src/app

COPY run.sh run.sh

CMD [ "./run.sh" ]
