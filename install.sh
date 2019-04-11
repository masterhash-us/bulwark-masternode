#!/usr/bin/env bash

while [ "$KEY" == "" ]
do
    KEY=$(whiptail --inputbox "Masternode Privkey" 8 78 --title "GinCoin Masternode Setup" --nocancel 3>&1 1>&2 2>&3)
done
echo "masternode=1" >> ~/.gincoincore/gincoin.conf
echo "masternodeprivkey=$KEY" >> ~/.gincoincore/gincoin.conf
sudo service gincoind restart

until gincoin-cli getinfo >/dev/null; do
  sleep 1;
done
