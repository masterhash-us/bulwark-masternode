#!/usr/bin/env bash

# Generate random passwords
RPCUSER=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
RPCPASSWORD=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

while [ "$KEY" == "" ]
do
    KEY=$(whiptail --inputbox "Masternode Privkey" 8 78 --title "Bulwark Masternode Setup" --nocancel 3>&1 1>&2 2>&3)
done
echo "masternode=1" >> ~/.bulwark/bulwark.conf
echo "masternodeprivkey=$KEY" >> ~/.bulwark/bulwark.conf
echo "rpcpassword=${RPCPASSWORD}"  >> ~/.bulwark/bulwark.conf
echo "rpcuser=${RPCUSER}"  >> ~/.bulwark/bulwark.conf
sudo service bulwarkd restart

until bulwark-cli getinfo >/dev/null; do
  sleep 1;
done
