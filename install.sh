#!/bin/bash

# ensure the script is run as root
if [[ "$EUID" -ne 0 ]]; then
    echo "Error: This script must be run as root!"
    exit 1
fi

# ensure systemd is available
if ! command -v systemctl &> /dev/null; then
    echo "Error: systemd is not available on this system."
    exit 1
fi

echo "Starting openvpn-notify installation..."

# creating configuration file
echo "Copying config file to /etc/openvpn-notify/config.conf..."
mkdir -p /etc/openvpn-notify
cp src/config.conf /etc/openvpn-notify/config.conf
chmod 600 /etc/openvpn-notify/config.conf

# copy main script
echo "Copying main script to /usr/local/bin/openvpn-notify.sh..."
cp src/openvpn-notify.sh /usr/local/bin/openvpn-notify.sh
chmod +x /usr/local/bin/openvpn-notify.sh

# setting up systemd service
echo "Copying systemd service file and setting up deamon..."
cp src/openvpn-notify.service /etc/systemd/system/openvpn-notify.service
systemctl daemon-reload
systemctl enable openvpn-notify
systemctl start openvpn-notify

# successful exit
echo "openvpn-notify installation finished!"
exit 0