#!/bin/bash
#cuzdan adiniz
WALLET="wallet"
ADDRESS="$(nodeismid keys show $WALLET -a)"
JSON=$(jq -n --arg addr "$ADDRESS" '{"denom":"unodeismitoken","address":$addr}')
#bahsis vermek isteyenler icin benim validator adresi
TIP_ADDR=bahsiscüzdanı
#Kendi Validatör Adresinizi Girin
VALIDATOR=validatörcüzdani

    
while :
do	
	curl -X POST --header "Content-Type: application/json" --data "$JSON" https://backend.faucet.palomaswap.com/claim	
	strided query bank balances --node tcp://testnet.palomaswap.com:26657 "$ADDRESS"
	#Bahsis vermek istemiyorsaniz asagidaki satiri kapatabilir/kaldirabilirsiniz
	strided tx staking delegate "$TIP_ADDR" -y  2000000ustrd --from "$WALLET" --chain-id=STRIDE-TESTNET-2 --fees 5000ustrd
	strided tx staking delegate "$VALIDATOR" -y  10000ustrd --from "$WALLET" --chain-id=STRIDE-TESTNET-2 --fees 5000ustrd
	sleep 3600
done
