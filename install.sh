#!/usr/bin/env bash

while [ "$KEY" == "" ]
do
    KEY=$(whiptail --inputbox "Masternode Privkey" 8 78 --title "Bulwark Masternode Setup" --nocancel 3>&1 1>&2 2>&3)
done
echo "masternodeprivkey=$KEY" >> ~/.bulwark/bulwark.conf
sudo service bulwarkd restart

until bulwark-cli getinfo; do
  sleep 1;
done