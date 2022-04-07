#!/bin/bash

YEAR=2021
IRPF_VERSION="1.1"

wget "http://downloadirpf.receita.fazenda.gov.br/irpf/${YEAR}/irpf/arquivos/IRPF${YEAR}-1.1.zip"

sudo unzip IRPF${YEAR}-${IRPF_VERSION}.zip -d /opt/ 
echo -e "[Desktop Entry]\n Version=1.0\n Name=irpf${YEAR}\n Exec=java -Xms128M -Xmx512M -jar /opt/IRPF${YEAR}/irpf.jar\n Icon=/\n Type=Application\n Categories=Application" | sudo tee "/usr/share/applications/irpf${YEAR}.desktop"
sudo chmod +x "/usr/share/applications/irpf${YEAR}.desktop"
ln -s "/usr/share/applications/irpf${YEAR}.desktop" ~/Desktop/
