FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl bzip2

# RUN useradd -ms /bin/bash monero
# USER monero
# WORKDIR /home/monero
WORKDIR /root

RUN curl https://downloads.getmonero.org/monero.linux.x64.v0-10-0-0.tar.bz2 -O &&\
  echo '6fe4cdb98d6ea7d2eded79841f70cb64edb840fcb2c84b904a1114424cffc5b1  monero.linux.x64.v0-10-0-0.tar.bz2' | sha256sum -c - &&\
  bzip2 -dc monero.linux.x64.v0-10-0-0.tar.bz2 | tar -xf - &&\
  rm monero.linux.x64.v0-10-0-0.tar.bz2 &&\
  rm monero-*

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18081

ENTRYPOINT ["./monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0"]
