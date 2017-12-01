FROM debian:stretch-slim

ENV MONERO_VERSION 0.11.1.0
ENV MONERO_SHA256 6581506f8a030d8d50b38744ba7144f2765c9028d18d990beb316e13655ab248

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends curl bzip2 ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

RUN groupadd -r monero && useradd -r -m -g monero monero

USER monero
ENV HOME /home/monero
WORKDIR /home/monero

RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v$MONERO_VERSION.tar.bz2 -O &&\
  echo "$MONERO_SHA256 monero-linux-x64-v$MONERO_VERSION.tar.bz2" | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  rm monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  cp ./monero-v$MONERO_VERSION/monerod . &&\
  rm -r monero-*

# blockchain loaction
VOLUME /home/monerod/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["./monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]
