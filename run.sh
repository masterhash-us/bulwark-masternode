#!/usr/bin/env bash

function Status() {
    if STATUS=$(alqo-cli masternode status 2>&1); then
        TXHASH=$(jq -r .txhash <<< "$STATUS")
        TXN=$(jq -r .outputidx <<< "$STATUS")
        TX="$TXHASH:$TXN"
        ADDRESS=$(jq -r .addr <<< "$STATUS")
        MESSAGE=$(jq -r .message <<< "$STATUS")
        whiptail --title "alqo Masternode" --msgbox "TX: $TX\nAddress: $ADDRESS\nStatus: $MESSAGE" 10 78
    else
        whiptail --title "alqo Masternode" --msgbox "Failed retriving masternode status.\n$STATUS" 10 78
    fi
}

function Restart() {
    sudo service alqod restart
    until alqo-cli getinfo >/dev/null; do
        sleep 1;
    done
}

function Refresh() {
    sudo service alqod stop
    rm -rf ~/.alqo/blocks ~/.alqo/database ~/.alqo/chainstate ~/.alqo/peers.dat
    sudo service alqod start
    until alqo-cli getinfo >/dev/null; do
        sleep 1;
    done
}

function Update() {
    cd /opt/masternode
    sudo git pull
    exec /opt/masternode/run.sh
}

function Shell() {
    exit 0
}

function Menu() {
    SEL=$(whiptail --nocancel --title "alqo Masternode" --menu "Choose an option" 16 78 8 \
        "Status" "Display masternode status." \
        "Restart" "Restart masternode." \
        "Refresh" "Wipe and reinstall blockchain." \
        "Update" "Update running masternode." \
        "Shell" "Drop to bash shell." \
        3>&1 1>&2 2>&3)
    case $SEL in
        "Status") Status;;
        "Restart") Restart;;
        "Refresh") Refresh;;
        "Update") Update;;
        "Shell") Shell;;
    esac
}

if ! grep -q "masternodeprivkey=" ~/.alqo/alqo.conf; then
    cd /opt/masternode
    sudo git pull
    bash /opt/masternode/install.sh
fi

while true; do Menu; done
