FROM debian:9

WORKDIR /root
RUN apt-get update -y
RUN apt-get install -y curl bzip2
RUN useradd -m -s /bin/bash monerod

USER monerod
ENV HOME /home/monerod
WORKDIR /home/monerod
RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v0.10.3.1.tar.bz2 -O &&\
  echo '8db80f8cc4f80d4106db807432828df730a59eac78972ea81652aa6b9bac04ad  monero-linux-x64-v0.10.3.1.tar.bz2' | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v0.10.3.1.tar.bz2 &&\
  rm monero-linux-x64-v0.10.3.1.tar.bz2 &&\
  cd ..
VOLUME /home/monerod/.bitmonero
EXPOSE 18080 18081
ENTRYPOINT ["./monero-v0.10.3.1/monerod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind"]
