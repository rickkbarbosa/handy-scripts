#!/bin/bash

DOCKER_IMAGE="mrbits/alpine-sshd"
FTP_DIR="/var/www/html/"
FTP_USER="a_user"
FTP_PASS='s3cr3t'

docker pull "${DOCKER_IMAGE}"
docker tag "${DOCKER_IMAGE}" ftpserver

docker run --restart=always -d -e "USER_${FTP_USER}"='{{ item.public_key }}' -e "PWD_${FTP_USER}"="${FTP_PASS}" -p 21:21 -v "${FTP_DIR}":/home/${FTP_USER} --name ftpserver-${FTP_USER} ftpserver:latest"