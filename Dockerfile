# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/root/.bitmonero --network=host --name=monerod -td kannix/monero-full-node
FROM debian:9

RUN apt-get update && apt-get install -y curl bzip2

# RUN useradd -ms /bin/bash monero
# USER monero
# WORKDIR /home/monero
WORKDIR /root

RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v0.11.1.0.tar.bz2 -O &&\
  echo '6581506f8a030d8d50b38744ba7144f2765c9028d18d990beb316e13655ab248  monero-linux-x64-v0.11.1.0.tar.bz2' | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v0.11.1.0.tar.bz2 &&\
  rm monero-linux-x64-v0.11.1.0.tar.bz2 &&\
  cp ./monero-v0.11.1.0/monerod . &&\
  rm -r monero-*

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]
