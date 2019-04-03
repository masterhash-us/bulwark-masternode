#!/usr/bin/env bash

function Status() {
    if STATUS=$(bulwark-cli masternode status 2>&1); then
        TXHASH=$(jq -r .txhash <<< "$STATUS")
        TXN=$(jq -r .outputidx <<< "$STATUS")
        TX="$TXHASH:$TXN"
        ADDRESS=$(jq -r .addr <<< "$STATUS")
        MESSAGE=$(jq -r .message <<< "$STATUS")
        whiptail --title "Bulwark Masternode" --msgbox "TX: $TX\nAddress: $ADDRESS\nStatus: $MESSAGE" 10 78
    else
        whiptail --title "Bulwark Masternode" --msgbox "Failed retriving masternode status.\n$STATUS" 10 78
    fi
}

function Refresh() {
    sudo service bulwarkd stop
    rm -rf ~/.bulwark.bulwark/blocks ~/.bulwark.bulwark/database ~/.bulwark.bulwark/chainstate ~/.bulwark.bulwark/peers.dat
    sudo service bulwarkd start
    until bulwark-cli getinfo; do
    sleep 1;
    done
}

function Update() {
    cd /opt/masternode
    sudo git pull
    exec "run.sh"
}

function Shell() {
    exit 0
}

function Menu() {
    SEL=$(whiptail --nocancel --title "Bulwark Masternode" --menu "Choose an option" 16 78 8 \
        "Status" "Display masternode status." \
        "Refresh" "Wipe and reinstall blockchain." \
        "Update" "Update running masternode." \
        "Shell" "Drop to bash shell." \
        3>&1 1>&2 2>&3)
    case $SEL in
        "Status") Status;;
        "Refresh") Refresh;;
        "Update") Update;;
        "Shell") Shell;;
    esac
}

if ! grep -q "masternodeprivkey=" ~/.bulwark/bulwark.conf; then
  bash /opt/masternode/install.sh
fi

while true; do Menu; done
