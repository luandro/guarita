#!/command/with-contenv bash
# shellcheck shell=bash

set -e

# SET PIHOLE ADMIN WEB PASSWORD
echo "=======" "Setting Pihole password" "====="
pihole -a -p "${WEBPASSWORD}" || { echo "Failed to set Pihole password"; exit 1; }

# TEMPORARY: remove in the next releases
echo "=======" "Disabling DHCP" "====="
pihole -a disabledhcp || { echo "Failed to disable DHCP"; exit 1; }
pihole -a setdns '127.0.0.1#5053' || { echo "Failed to set DNS"; exit 1; }

# SET DOMAIN FOR LOCAL SERVICES
echo "=======" "Adding local domain to dnsmasq" "====="
DOMAIN="${LOCAL_DOMAIN:=wai.com}"
IP="${LOCAL_IP:=192.168.1.13}"

echo "address=/$DOMAIN/$IP" > /etc/dnsmasq.d/03-custom-dns.conf

# Show interfaces
while [ -z "$(ip -o -4 addr show dev "${INTERFACE}")" ]
do
   echo "Waiting for IPv4 address on ${INTERFACE}..."
   sleep 5
done

# force dnsmasq to bind only the interfaces it is listening on
echo "bind-interfaces" > /etc/dnsmasq.d/balena.conf

# Fetch Balena host IP
# BALENA_HOST_IP=$(curl -s -H "Authorization: Bearer ${BALENA_SUPERVISOR_API_KEY}" "${BALENA_SUPERVISOR_ADDRESS}/v1/device?apikey=${BALENA_SUPERVISOR_API_KEY}" | jq -r ".ip_address")

# TODO: Use Balena host IP to generate custom DNS
