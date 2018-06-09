# monero-full-node

docker image to run a monero full network node

## How To Use

``` 
docker run -td \
--restart=always \
-v /var/data/blockchain-xmr:/root/.bitmonero \
-p 18080:18080 \
-p 18081:18081 \
--name=monerod \
kannix/monero-full-node
```

## Updates
Manual Way
```
docker stop monerod
docker rm monerod
docker pull kannix/monero-full-node
```
Then launch the using the command above

Automatic way
https://github.com/v2tec/watchtower
