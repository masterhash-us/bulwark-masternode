#!/usr/bin/env bash
echo -e "Default \e[104mLight blue"

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
echo "rpcallowip=127.0.0.1" >> ~/.bulwark/bulwark.conf
echo "server=1" >> ~/.bulwark/bulwark.conf
sudo systemctl start bulwarkd.service

until bulwark-cli getinfo >/dev/null; do
  sleep 1;
done
