#!/bin/bash
#IRPF - Declaração do Imposto de Renda [Brazil] installation. Java installed is previously needed.

YEAR=$(date +"%Y";)
IRPF_VERSION="1.1"

wget -k "https://downloadirpf.receita.fazenda.gov.br/irpf/${YEAR}/irpf/arquivos/IRPF${YEAR}-${IRPF_VERSION}.zip"

sudo unzip IRPF${YEAR}-${IRPF_VERSION}.zip -d /opt/ 
echo -e "[Desktop Entry]\n Version=1.0\n Name=irpf${YEAR}\n Exec=java -Xms128M -Xmx512M -jar /opt/IRPF${YEAR}/irpf.jar\n Icon=/\n Type=Application\n Categories=Application" | sudo tee "/usr/share/applications/irpf${YEAR}.desktop"
sudo chmod +x "/usr/share/applications/irpf${YEAR}.desktop"


LINUX_USERS=$(egrep ':x:100[0-9]' /etc/passwd | cut -d ':' -f 6;)
for USER in $LINUX_USERS; do 
  ln -s "/usr/share/applications/irpf${YEAR}.desktop" ${USER}/Desktop/ 
done
