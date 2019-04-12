#!/usr/bin/env bash

while [ "$KEY" == "" ]
do
    KEY=$(whiptail --inputbox "Masternode Privkey" 8 78 --title "Alqo Masternode Setup" --nocancel 3>&1 1>&2 2>&3)
done
echo "masternode=1" >> ~/.alqo/alqo.conf
echo "masternodeprivkey=$KEY" >> ~/.alqo/alqo.conf
sudo service alqod restart

until alqo-cli getinfo >/dev/null; do
  sleep 1;
done
