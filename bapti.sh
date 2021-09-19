#!/bin/bash


echo "<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo "<<<<<<<<<<<<<<<<<<      Welcome      >>>>>>>>>>>>>>>>>>>>"
echo "<<<<<<<<<<<<<<<<<<       to the      >>>>>>>>>>>>>>>>>>>>"
echo "<<<<<<<<<<<<<<<<<< LOBSTER CHALLENGE >>>>>>>>>>>>>>>>>>>>"
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo "ICAgICAgX19fXwogICAgIC8gIF9fXAogICAgfDogLy0tLSkgIFwgICAgLyAgIF9fXwogICAgIFw6
KCBfLyAgICBcICAvICAgL18gIFwKICAgICAgXCAgXCAgICAgIFwvICAgIFxfXDo6KQogICAgICAg
XF8gXCAgIF8wIiIwXyAgIC8gXy8KICAgICAgICAgXCBcLz0gIFwvICA9XC8gLwogICAgICAgICAg
XCB8ICAofHwpICB8IC8KICAgICAgICAgICBcX1xfX19fX18vXy8KICAgICAgICAgICBfXy8vICAg
IFxcX18KICAgICAgICAgIC9fXy8vPT09PVxcX19cCiAgICAgICBfIC8vX18vLz09PT1cXF9fXFwg
XwogICAgICAgXyAvL19fLy89PT09XFxfX1xcIF8KICAgICAgIF8gLy8gICAvKCAgKVwgICBcXCBf
CiAgICAgICBfIC8gICAgLyggIClcICAgIFwgXwogICAgICAgICAgICAgIHwoICApfAogICAgICAg
ICAgICAgIC8gICAgXAogICAgICAgICAgICAgLyAvfHxcIFwKICAgICAgICAgICAgIFw6Xy9cXzov
ICAgU0B5YU4KICAgICAgICAgICAgICAgICAgICAgICAxMS4xMS4wMgo=" | base64 -d

wallet=$1

# Generate new wallet if needed
echo ">>> Create new wallet if needed"
mkdir $wallet
if [ $? -eq 0 ]; then
	cardano-cli address key-gen --verification-key-file $wallet/payment.vkey --signing-key-file $wallet/payment.skey
	cardano-cli address build --payment-verification-key-file payment.vkey --mainnet --out-file $wallet/payment.addr
fi

addr=$(cat $wallet/payment.addr)

# Fund the wallet
# Uncomment and modify for auto funding via cardano-wallet
#echo ">>> Fund $wallet"
#echo "$WALLET_PASSWORD" | ../cardano-wallet/result/bin/cardano-wallet transaction create e81db6c24a41d403d9159ff612bcceaf3a60610d --payment 2000000@$addr > /dev/null

# check that funds have arrived then make a lobster contribute
echo ">>> Waiting for funds to arrive"
from=$(./mainnet-utxo-at.sh $wallet/payment.addr | grep 2000000 | head -1 | awk '{print $1}')
while [ -z "$from" ]
do
      echo ">>> Pending... send 2 ada to"
      echo "$addr"
      sleep 3
      from=$(./mainnet-utxo-at.sh $wallet/payment.addr | grep 2000000 | awk '{print $1}')
done

echo ">>> Fund have arrived"

lobster=$(./mainnet-utxo-at.sh addr.lobster | grep LobsterNFT)
to=$( echo $lobster | awk '{print $1}')
currentCounter=$( echo $lobster | awk '{print $9}')
newCounter=$( expr $currentCounter + $(expr \( $RANDOM + 1 \) % 101))
votes=$( echo $lobster | awk '{print $12}')

if $votes -eq 500; then
	echo "Lobster challange complete"
	exit 0
fi
	

echo "from: $from#0"
echo "to:   $to#1"
echo "current counter: $currentCounter"
echo "new counter: $newCounter"
echo "votes: $votes"

./lobster-contribute.sh $from#0 $to#1 $wallet/payment.addr $wallet/payment.skey $currentCounter $newCounter $votes

if [ $? -eq 0 ]; then
	mv lobster-tx* $wallet
else
    echo "Lobster transaction failed"
fi



