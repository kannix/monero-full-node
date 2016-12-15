# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/root/.bitmonero --network=host --name=monerod -td kannix/monero-full-node
FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl bzip2

# RUN useradd -ms /bin/bash monero
# USER monero
# WORKDIR /home/monero
WORKDIR /root

RUN curl https://downloads.getmonero.org/monero.linux.x64.v0-10-1-0.tar.bz2 -O &&\
  echo 'bf09eea27c957e7e2bdd62dac250888b301d4d25abe18d4a5b930fa7477708c7  monero.linux.x64.v0-10-1-0.tar.bz2' | sha256sum -c - &&\
  bzip2 -dc monero.linux.x64.v0-10-1-0.tar.bz2 | tar -xf - &&\
  rm monero.linux.x64.v0-10-1-0.tar.bz2 &&\
  rm monero-*

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0"]
