#!/bin/bash

export CARDANO_NODE_SOCKET_PATH=/home/nils/Programmering/cardano/cardano-node/state-node-mainnet/node.socket

cardano-cli query utxo \
    --mainnet \
    --address $(cat $1)
