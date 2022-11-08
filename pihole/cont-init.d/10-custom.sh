#!/usr/bin/with-contenv bash
# shellcheck shell=bash

set -e

# SET PIHOLE ADMIN WEB PASSWORD
echo "=======" "Setando senha do Pihole" "====="
pihole -a -p "${WEBPASSWORD}" || true
# TEMPORÁRIO: remover nos próximos releases
echo "=======" "Removendo bloqueio e desabilitando DHCP" "====="
# pihole --regex -d '.*' # Pode estar dando problema
pihole -a disabledhcp

# SET DOMAIN FOR LOCAL SERVICES
echo "=======" "Adiciona domínio local ao dnsmasq" "====="
DOMAIN="${LOCAL_DOMAIN:=nhandeflix.com}"
IP="${LOCAL_IP:=192.168.1.13}"

echo "address=/$DOMAIN/$IP" > /etc/dnsmasq.d/03-custom-dns.conf

# Add Youtube add-blocking
# TODO: Analize if lists are safe and useful:
# https://github.com/kboghdady/youTube_ads_4_pi-hole
# https://github.com/blocklistproject/Lists
# https://github.com/lightswitch05/hosts
# https://github.com/jacklul/pihole-updatelists
echo "=======" "Adiciona regras de bloqueio para Youtube" "====="
# This script will fetch the Googlevideo ad domains and append them to the Pi-hole block list.
# Run this script daily with a cron job (don't forget to chmod +x)
# More info here: https://discourse.pi-hole.net/t/how-do-i-block-ads-on-youtube/253/136
# Original url: https://gist.github.com/ErikFontanel/4ee1ab393b119690a293ba558976b113

# File to store the YT ad domains
FILE=/etc/pihole/youtube.hosts

# Fetch the list of domains, remove the ip's and save them
curl 'https://api.hackertarget.com/hostsearch/?q=googlevideo.com' \
| awk -F, 'NR>1{print $1}' \
| grep -vE "redirector|manifest" > $FILE

# Replace r*.sn*.googlevideo.com URLs to r*---sn-*.googlevideo.com
# and add those to the list too
cat $FILE | sed -r 's/(^r[[:digit:]]+)(\.)(sn)/\1---\3-/' >> $FILE

# Scan log file for previously accessed domains
grep '^r.*googlevideo\.com' /var/log/pihole*.log \
| awk '{print $8}' \
| grep -vE "redirector|manifest" \
| sort | uniq >> $FILE

# Add to Pi-hole adlists if it's not there already
if ! grep $FILE < /etc/pihole/adlists.list; then echo "file://$FILE" >> /etc/pihole/adlists.list; fi;

# Add pornography list to pihole


# Show interfaces
while [ -z "$(ip -o -4 addr show dev "${INTERFACE}")" ]
do
   echo "Waiting for IPv4 address on ${INTERFACE}..."
   sleep 5
done

# https://serverfault.com/a/817791
# force dnsmasq to bind only the interfaces it is listening on
# otherwise dnsmasq will fail to start since balena is using 53 on some interfaces
echo "bind-interfaces" > /etc/dnsmasq.d/balena.conf

# TODO: Fetch ip address from Balena supervisor and generate custom dns:
# Python example:
# WGET = subprocess.Popen (['wget', '-qO-', os.environ["BALENA_SUPERVISOR_ADDRESS"]+"/v1/device?apikey="+os.environ["BALENA_SUPERVISOR_API_KEY"]],  stdout=subprocess.PIPE)
# output = subprocess.check_output ([ "jq", "-r", ".ip_address" ], stdin=WGET.stdout).split()
# WGET.wait()
# IP_ADDRESS = output[1]