# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/root/.bitmonero --network=host --name=monerod -td kannix/monero-full-node
FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl bzip2

# RUN useradd -ms /bin/bash monero
# USER monero
# WORKDIR /home/monero
WORKDIR /root

RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v0.10.2.1.tar.bz2 -O &&\
  echo '9edba6ca91c35c6c2eb6816f9342931c88648de5beb471943ea63d0b16c9a2e4  monero-linux-x64-v0.10.2.1.tar.bz2' | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v0.10.2.1.tar.bz2 &&\
  rm monero-linux-x64-v0.10.2.1.tar.bz2 &&\
  cp ./monero-v0.10.2.1/monerod . &&\
  rm -r monero-*

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]
