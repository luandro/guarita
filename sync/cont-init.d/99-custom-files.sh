#!/usr/bin/with-contenv bash
# shellcheck shell=bash

file=/config/firstboot

if [ ! -e "$file" ]; then
    echo "First run!"
    echo "================================"
    if [[ $SYNC_ID_PRINCIPAL && $SYNC_NOME_PRINCIPAL && $SYNC_ID_ACERVO && $SYNC_NOME_ACERVO ]]; then
        echo "=======" "Adding variables" "====="
        sed -i -r "s/#ID_PRINCIPAL/$SYNC_ID_PRINCIPAL/g" /config/config.xml
        sed -i -r "s/#NOME_PRINCIPAL/$SYNC_NOME_PRINCIPAL/g" /config/config.xml
        sed -i -r "s/#ID_ACERVO/$SYNC_ID_ACERVO/g" /config/config.xml
        sed -i -r "s/#NOME_ACERVO/$SYNC_NOME_ACERVO/g" /config/config.xml
    fi
    if [[ $ADMIN_LOGIN && $ADMIN_PASSWORD]]; then
        echo "=======" "Adding authentication and setting permissions" "====="
        syncthing generate --home=/config --gui-user=${ADMIN_LOGIN} --gui-password=${ADMIN_PASSWORD}
    fi
    mkdir -p /data
    chown -R 1000:1000 /config
    chown -R 1000:1000 /data
    touch "$file"
fi

if [ ! -w "$file" ]; then
    echo "Firstboot already happened"
    exit 1
fi
