#!/usr/bin/env bash

while [ "$KEY" == "" ]
do
    KEY=$(whiptail --inputbox "Masternode Privkey" 8 78 --title "Swiftcash Masternode Setup" --nocancel 3>&1 1>&2 2>&3)
done
echo "masternode=1" >> ~/.bulwark/bulwark.conf
echo "masternodeprivkey=$KEY" >> ~/.swiftcash/swiftcash.conf
sudo service swiftcashd restart

until swiftcash-cli getinfo >/dev/null; do
  sleep 1;
done
