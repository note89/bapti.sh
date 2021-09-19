Welcome! 

Let's leave this lobster unamed no longer! 
With this repo will help you be part of this momentus milestone. 
The script will

* Generate a new wallet
* Tell you where to send 2 ada
* Submit a transaction to the lobster challenge
* And get us one step closer to have the challenge completed

### How to use

1. Start Daedalus or a sepperate cardano node.
2. Set `CARDANO_NODE_SOCKET_PATH`
```
export CARDANO_NODE_SOCKET_PATH=$(ps ax | grep -v grep | grep cardano-wallet | grep mainnet | sed -r 's/(.*)node-socket //' |  grep cardano-node.socket )
```

3. Run `bapti.sh` for fun and profit

```
./bapti.sh <wallet-name>
```

### Example

```
./bapti.sh lobsterWallet
```


### CARDANO_NODE_SOCKET_PATH Envirionment variable explanation

You need to set the `CARDANO_NODE_SOCKET_PATH` to where you have your cardano node socket set. 
If you already have a node running you can set it with the following command. 

```
export CARDANO_NODE_SOCKET_PATH=$(ps ax | grep -v grep | grep cardano-wallet | grep mainnet | sed -r 's/(.*)node-socket //' |  grep cardano-node.socket )
echo $CARDANO_NODE_SOCKET_PATH
```

https://cardano.stackexchange.com/questions/895/using-cardano-node-installed-by-daedalus-as-cli



