# monero-full-node

docker image to run a monero full network node

# Usage

`docker run -d --restart=always -v xmrchain:/home/monero/.bitmonero -p 18080:18080 -p 18081:18081 --name=monerod stubdalnet/monero-full-node`

## Updates
Manual Way
```
docker stop monerod
docker rm monerod
docker pull molokai/monero-full-node
```
Then launch using the "how to use" command above

# Donations

If you find this useful and want to contribute, please donate to the [Monero General Fund](https://ccs.getmonero.org/) that supports the continued devleopment of Monero:
```888tNkZrPN6JsEgekjMnABU4TBzc2Dt29EPAvkRxbANsAnjyPbb3iQ1YBRk1UXcdRsiKc9dhwMVgN5S9cQUiyoogDavup3H```


# History 

### November 2022: note

It seems the original author has stopped merging pull requests, so I'm now maintaining this on my own terms from now on.
Changed the base from Ubuntu to Arch linux.

### October 2018: Breaking Change
**warning**  
for improved security the new images will run the monero daemon under it's own user and not as root anymore!
If you simply upgrade without following the next steps you will run into this error:  
`WARN 	blockchain.db.lmdb	src/blockchain_db/lmdb/db_lmdb.cpp:75	Failed to open lmdb environment: Permission denied`

this can be fixed with the following steps  

* stop and remove the current container: `docker stop monerod && docker rm monerod`
* change the owner of the volume to monero user `docker run -v xmrchain:/home/monero/.bitmonero -t --rm --name=monerod -u root --entrypoint=/bin/chown kannix/monero-full-node -R monero:monero .bitmonero`
* start the container `docker run -tid --restart=always -v xmrchain:/home/monero/.bitmonero -p 18080:18080 -p 18081:18081 --name=monerod kannix/monero-full-node`

**Hint:** keep in mind that you have to adapt your volume bindings to your own configuration e.g. if you followed the older version of this readme you have to use: `-v /var/data/blockchain-xmr:/home/monero/.bitmonero` instead of `-v xmrchain:/home/monero/.bitmonero`
