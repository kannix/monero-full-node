# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/root/.bitmonero --network=host --name=monerod -td kannix/monero-full-node
FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl bzip2

# RUN useradd -ms /bin/bash monero
# USER monero
# WORKDIR /home/monero
WORKDIR /root

RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v0.10.3.0.tar.bz2 -O &&\
  echo 'f164112bea75dfd3eaaa905d21129820a996bbe6e5d65cb194609c672a71c3fe  monero-linux-x64-v0.10.3.0.tar.bz2' | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v0.10.3.0.tar.bz2 &&\
  rm monero-linux-x64-v0.10.3.0.tar.bz2 &&\
  cp ./monero-v0.10.3.0/monerod . &&\
  rm -r monero-*

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]
