#!/usr/bin/with-contenv bash
# shellcheck shell=bash

echo "=======" "Adiciona variaveis do Acervo" "====="

sed -i -r "s/#ID_PRINCIPAL/$SYNC_ID_PRINCIPAL/g" /config/config.xml
sed -i -r "s/#NOME_PRINCIPAL/$SYNC_NOME_PRINCIPAL/g" /config/config.xml
sed -i -r "s/#ID_ACERVO/$SYNC_ID_ACERVO/g" /config/config.xml
sed -i -r "s/#NOME_ACERVO/$SYNC_NOME_ACERVO/g" /config/config.xml
