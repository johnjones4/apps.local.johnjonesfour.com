from ubuntu

WORKDIR /

RUN apt-get update && apt-get install -y wget gnupg gnupg2 gnupg1 lsb-release
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee  /etc/apt/sources.list.d/pgdg.list
RUN apt-get update && apt-get install -y postgresql-client-13

COPY backup.sh /backup.sh
COPY dbs.txt /dbs.txt

VOLUME ["/backup"]

CMD ["/backup.sh"]
