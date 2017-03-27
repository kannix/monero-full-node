# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/root/.bitmonero --network=host --name=monerod -td kannix/monero-full-node
FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl bzip2

# RUN useradd -ms /bin/bash monero
# USER monero
# WORKDIR /home/monero
WORKDIR /root

RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v0.10.3.1.tar.bz2 -O &&\
  echo '8db80f8cc4f80d4106db807432828df730a59eac78972ea81652aa6b9bac04ad  monero-linux-x64-v0.10.3.1.tar.bz2' | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v0.10.3.1.tar.bz2 &&\
  rm monero-linux-x64-v0.10.3.1.tar.bz2 &&\
  cp ./monero-v0.10.3.1/monerod . &&\
  rm -r monero-*

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]
