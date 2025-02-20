#!/bin/bash

# load config file
CONFIG_FILE="/etc/openvpn-notify/config.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Config file $CONFIG_FILE not found! Retrying in 30 seconds..." | systemd-cat -t openvpn-notify -p err
    exit 1
fi

# load telegram credentials
source "$CONFIG_FILE"

# openvpn server service log command
JOURNAL_CMD="sudo journalctl -u openvpn-server@server -f -n 0"

# string pattern for successful connection
MATCH_PATTERN="Peer Connection Initiated with"

# sending telegram notification
telegram_message() {
    local MESSAGE="$1"
    local URL="https://api.telegram.org/bot${BOT_TOKEN}/sendMessage"

    RESPONSE=$(curl -s -X POST "$URL" -d chat_id="$CHAT_ID" -d text="$MESSAGE")
    if [[ "$RESPONSE" != *"\"ok\":true"* ]]; then
        echo "Failed to send Telegram message: $RESPONSE" | systemd-cat -t openvpn-notify -p err
    fi
}

# monitor openvpn logs
$JOURNAL_CMD | while read LINE; do
    if [[ "$LINE" == *"$MATCH_PATTERN"* ]]; then
        # get ip and user from line
        CLIENT_IP=$(echo "$LINE" | grep -oP '(?<=\[AF_INET\])\d+\.\d+\.\d+\.\d+')
        USERNAME=$(echo "$LINE" | awk -F'[][]' '{print $4}')

        # log to systemd journal
        echo "User $USERNAME connected from IP: $CLIENT_IP" | systemd-cat -t openvpn-notify -p info

        # send telegram notification
        telegram_message "User $USERNAME connected from IP: $CLIENT_IP"
    fi
done
