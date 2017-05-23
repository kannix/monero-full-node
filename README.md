# Monerod Docker image

This is a Docker image to run the Monero daemon.

By default, it will load the blockchain from `~/.bitmonero`, so make sure that you're not running a Monero daemon on your host as well.

Build with

```docker build -t monerod .```

Run with

```docker run -p 18080:18080 -p 18081:18081 --restart=always -v ~/.bitmonero:/home/monerod/.bitmonero --name=monerod -td monerod:latest```

View logs with

```docker logs -f monerod```

