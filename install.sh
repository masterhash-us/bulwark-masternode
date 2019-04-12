#!/usr/bin/env bash

while [ "$KEY" == "" ]
do
    KEY=$(whiptail --inputbox "Masternode Privkey" 8 78 --title "Magnet Masternode Setup" --nocancel 3>&1 1>&2 2>&3)
done
echo "masternode=1" >> ~/.mag/mag.conf
echo "masternodeprivkey=$KEY" >> ~/.mag/mag.conf
sudo service magd restart

until mag-cli getinfo >/dev/null; do
  sleep 1;
done
