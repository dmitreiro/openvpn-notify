# openvpn-notify
This service sniffs OpenVPN server logs to monitor when a client successfully connects to the server and sends Telegram real-time notifications about the client's name and IP address.

***

## :gear: Setup

:warning: **Warning**: before you proceed, make sure your Linux OS uses `systemd` as a service manager.

Open terminal, change your current working directory to the location where you want the cloned directory and then clone this repository to your local machine

```
git clone https://github.com/dmitreiro/openvpn-notify.git
```

Then, navigate to your repository home folder, give execution permission to `install.sh` and run it as sudo

```
cd openvpn-notify/
chmod +x install.sh
sudo ./install.sh
```

When the installation finishes, edit `/etc/openvpn-notify/config.conf` config file (open as sudo) and write your Telegram bot `token` and `chat_id`.

```
BOT_TOKEN="your_bot_token_here"
CHAT_ID="your_chat_id_here"
```

After setting up config file, restart systemd service to apply changes

```
sudo systemctl restart openvpn-notify.service
```

Now, you are ready to rock :sunglasses:

To check service status run

```
sudo systemctl status openvpn-notify.service
```

To check service logs run

```
sudo journalctl -t openvpn-notify -f

```

## :balance_scale: License

This project is licensed under the MIT License, which allows anyone to use, modify, and distribute this software for free, as long as the original copyright and license notice are included. See the [LICENSE](LICENSE) file for more details.