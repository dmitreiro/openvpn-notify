# openvpn-notify
This code was created with the purpose of sniff OpenVPN server logs, sending Telegram notifications as soon as a client successfully connects to a server.

***

## :gear: Setup

### Clone

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
After this, restart systemd service

```
sudo systemctl restart openvpn-notify.service
```

Now, you are ready to rock :sunglasses:\

## :balance_scale: License

This project is licensed under the MIT License, which allows anyone to use, modify, and distribute this software for free, as long as the original copyright and license notice are included. See the [LICENSE](LICENSE) file for more details.