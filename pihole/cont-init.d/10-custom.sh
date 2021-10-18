#!/usr/bin/with-contenv bash
# shellcheck shell=bash

set -e

pihole -a -p "${WEBPASSWORD}" || true

# Add Whitelist
pihole --white-regex '(\.|^)whatsapp\.com$'
pihole --white-regex '(\.|^)whatsapp\.net$'
pihole --white-regex '(\.|^)fbcdn\.net$'
pihole --white-regex '(\.|^)wa\.me$'
pihole --white-regex '(\.|^)signal\.org$'
pihole --white-regex '(\.|^)whispersystems\.org$'
pihole --white-regex '(\.|^)souqcdn\.com$'

while [ -z "$(ip -o -4 addr show dev "${INTERFACE}")" ]
do
   echo "Waiting for IPv4 address on ${INTERFACE}..."
   sleep 5
done
