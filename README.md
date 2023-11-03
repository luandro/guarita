# Guarita
[![Balena Push Release](https://github.com/luandro/guarita/actions/workflows/balena-push-release.yml/badge.svg)](https://github.com/luandro/guarita/actions/workflows/balena-push-release.yml)

Guarita is designed to enhance the Internet experience. It offers ad blocking, privacy protection, and parental control. It also allows syncing content from a curated repository and streaming it through an intuitive interface. It is optimized for deployment on a Raspberry Pi device and can be managed remotely via balenaCloud.

Guarita also includes an NTP server for use with your router, ensuring your network's clock is always up to date. This is particularly useful for implementing router-level internet blocks.

## Features

This project is a [balenaCloud](https://www.balena.io/cloud) stack with the following services:

- AdGuard: A network-wide ad blocking service. [More Info](https://adguard.com/)
- Wireguard: A simple WireGuard VPN server GUI. [More Info](https://www.wireguard.com/)
- Jellyfin: A free software media system that lets you control your media from a web interface. [More Info](https://jellyfin.org/)
- Syncthing: A service to sync folders across devices. [More info](https://syncthing.net/)
- NTP: A Network Time Protocol server.
- Hostname: A service to set a custom hostname on application start.

## Getting Started

You can one-click-deploy this project to balena using the button below:

[![deploy button](https://balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/luandro/guarita&defaultDeviceType=raspberrypi3)


## Hardware required

- Raspberry Pi 3 or 4
- 16GB Micro-SD Card (we recommend Sandisk Extreme Pro SD cards)
- Micro-USB cable
- Power supply
- Case and cooling (optional but recommended)
- Ethernet cable

## Environment Variables

Device Variables apply to all services within the application, and can be applied fleet-wide to apply to multiple devices. If you used the one-click-deploy method, the default environment variables will already be added for you to customize as needed.

| Service | Variable | Example | Description |
| ------- | -------- | ------- | ----------- |
| AdGuard | - | - | - |
| Wireguard | WG_HOST | 192.168.0.1 | The host IP for the WireGuard VPN server |
| Wireguard | PASSWORD | admin | The password for the WireGuard VPN server |
| Hostname | SET_HOSTNAME | waiapi | Set a custom hostname on application start |
| Jellyfin | PUID | 1000 | User ID |
| Jellyfin | PGID | 1000 | Group ID |
| Sync | PUID | 1000 | User ID |
| Sync | PGID | 1000 | Group ID |
| Sync | TZ | America/Brasil | Timezone |
| NTP | NTP_SERVERS | time.cloudflare.com | NTP server to use |
| NTP | LOG_LEVEL | 0 | Log level for the NTP server |

## IP Addresses

| Service | IP Address |
| ------- | ---------- |
| Jellyfin | 80 |
| Sync | 82 |
| Wireguard | 83 |
| AdGuard | 84 |
| NTP | 123 |

Please note that these IP addresses are the default ones and can be changed according to your network configuration.

## Remote Support

In order to ssh into the devices you'll need to be part of the org that created the fleet and have your public ssh key added to the [Balena Dashboard](https://www.balena.io/docs/learn/manage/ssh-access/#add-an-ssh-key-to-balenacloud). Balena devices use port `22222` for ssh. The easiest way to work with Balena remotely is by installing the [Balena CLI](https://www.balena.io/docs/reference/balena-cli/).And be sure to check documentation for more information on [ssh access](https://www.balena.io/docs/learn/manage/ssh-access/).

To ssh into a machine simply run:

```
balena ssh <uuid>
```

Replacing with the device's uuid which can be obtained from the cli or the cloud dashboard. If we want to enter the dashboard of a router on the device's network, first you'll need to tunnel the ssh port:

```
balena tunnel <uuid> -p 22222:22222
```

On another terminal ssh into local host which is tunneling the device, using the `-D` option:
```
ssh -D 9090 gh_luandro@localhost -p 22222
```

Then finally configure a sock5 proxy on the browser using the gui, or with [Chromium](https://www.chromium.org/getting-involved/download-chromium/) installed, run in another terminal:
```
chromium --proxy-server="socks5://localhost:9090"
```

The browser window that opens up will be tunneling the device, so if a router's ip is `192.168.1.1` opening that in the browser will open the router's dashboard if it's running on router's port 80.

## Help

If you're having trouble getting the project running,
submit an issue or post on the forums at <https://forums.balena.io>.

## Contributing

Please open an issue or submit a pull request with any features, fixes, or changes.
