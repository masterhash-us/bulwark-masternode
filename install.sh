#!/usr/bin/env bash

while [ "$KEY" == "" ]
do
    KEY=$(whiptail --inputbox "Masternode Privkey" 8 78 --title "Phore Masternode Setup" --nocancel 3>&1 1>&2 2>&3)
done
echo "masternode=1" >> ~/.phore/phore.conf
echo "masternodeprivkey=$KEY" >> ~/.phore/phore.conf
sudo service phored restart

until phore-cli getinfo >/dev/null; do
  sleep 1;
done
