# Monerod Docker image

This is a Docker image to run the Monero daemon.

By default, it will load the blockchain from `~/.bitmonero`, so make sure that you're not running a Monero daemon on your host as well.

Build with

```docker build -t monerod .```

Run with

```./start-container.sh```

View logs with

```docker logs -f monerod```

