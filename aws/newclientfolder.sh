#!/bin/bash
CLIENTS_DIR=~/working/clients 

echo -n "Client Name > "
read -s CLIENT_NAME

echo -n "Please type your AWS ACCESS KEY > "
read -s AWS_ACCESS_KEY

echo -n "Please type your AWS SECRET KEY > "
read -s AWS_ACCESS_SECRET_KEY

mkdir -p "${CLIENTS_DIR}/${CLIENT_NAME}"
echo "export AWS_ACCESS_KEY=\"${AWS_ACCESS_KEY}\"
export AWS_ACCESS_SECRET_KEY=\"${AWS_ACCESS_SECRET_KEY}\"

#Set Credentials
~/.set_awscredentials.sh"  > "${CLIENTS_DIR}/${CLIENT_NAME}/.env"
