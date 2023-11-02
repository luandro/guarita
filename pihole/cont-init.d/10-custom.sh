#!/command/with-contenv bash
# shellcheck shell=bash

set -e

# SET PIHOLE ADMIN WEB PASSWORD
echo "=======" "Setando senha do Pihole" "====="
pihole -a -p "${WEBPASSWORD}" || true
# TEMPORÁRIO: remover nos próximos releases
echo "=======" "desabilitando DHCP" "====="
# pihole --regex -d '.*' # isso era preciso para limpar regex antigos
pihole -a disabledhcp
pihole -a setdns '127.0.0.1#5053'
pihole -a setdns '127.0.0.1#5053'

# SET DOMAIN FOR LOCAL SERVICES
echo "=======" "Adiciona domínio local ao dnsmasq" "====="
DOMAIN="${LOCAL_DOMAIN:=wai.com}"
IP="${LOCAL_IP:=192.168.1.13}"

echo "address=/$DOMAIN/$IP" > /etc/dnsmasq.d/03-custom-dns.conf

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