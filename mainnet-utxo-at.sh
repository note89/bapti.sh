#!/bin/bash
cardano-cli query utxo \
    --mainnet \
    --address $(cat $1)
