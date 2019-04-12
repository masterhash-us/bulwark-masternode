#!/usr/bin/env bash

while [ "$KEY" == "" ]
do
    KEY=$(whiptail --inputbox "Masternode Privkey" 8 78 --title "Bitsend Masternode Setup" --nocancel 3>&1 1>&2 2>&3)
done
echo "masternode=1" >> ~/.bitsend/bitsend.conf
echo "masternodeprivkey=$KEY" >> ~/.bitsend/bitsend.conf
sudo service bitsendd restart

until bitsend-cli getinfo >/dev/null; do
  sleep 1;
done
