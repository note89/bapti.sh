#!/bin/bash
export CARDANO_NODE_SOCKET_PATH=/home/nils/Programmering/cardano/cardano-node/state-node-mainnet/node.socket
cardano-cli query protocol-parameters \
    --mainnet \
    --out-file "mainnet-protocol-parameters.json"
