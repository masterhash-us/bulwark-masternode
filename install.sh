#!/usr/bin/env bash

while [ "$KEY" == "" ]
do
    KEY=$(whiptail --inputbox "Masternode Privkey" 8 78 --title "SmartChash Masternode Setup" --nocancel 3>&1 1>&2 2>&3)
done
echo "masternode=1" >> ~/.smartcash/smartcash.conf
echo "masternodeprivkey=$KEY" >> ~/.smartcash/smartcash.conf
sudo service smartcashd restart

until smartcash-cli getinfo >/dev/null; do
  sleep 1;
done
