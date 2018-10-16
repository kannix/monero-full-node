# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/root/.bitmonero -p 18080:18080 -p 18081:18081 --name=monerod -td kannix/monero-full-node
FROM ubuntu:18.04 AS build

ENV MONERO_VERSION=0.13.0.2 MONERO_SHA256=a59fc0fffb325b4f92a5b500438bf340ddbf78e91581eb4df95ad2d5e5fb42a8

RUN apt-get update && apt-get install -y curl bzip2

WORKDIR /root

RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v$MONERO_VERSION.tar.bz2 -O &&\
  echo "$MONERO_SHA256  monero-linux-x64-v$MONERO_VERSION.tar.bz2" | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  rm monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  cp ./monero-v$MONERO_VERSION/monerod . &&\
  rm -r monero-*
  
FROM ubuntu:18.04

RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero

COPY --chown=monero:monero --from=build /root/monerod /home/monero/monerod

# blockchain loaction
VOLUME /home/monero/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]
