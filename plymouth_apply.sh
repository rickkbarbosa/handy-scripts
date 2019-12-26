#!/bin/bash
#Apply a plymouth theme

PLYMOUTH_PATH="where-is-the-downloaded-file"
PLYMOUTH_NAME=$(basename "${PLYMOUTH_PATH}")
PLYMOUTH_FILE=$(basename $(ls "${PLYMOUTH_PATH}"/*.plymouth;); )

cp -r ${PLYMOUTH_PATH} /usr/share/plymouth/themes/

update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/"${PLYMOUTH_NAME}"/"${PLYMOUTH_FILE}" 100

sudo update-alternatives --config default.plymouth
sudo update-initramfs -u

#To Test:
sudo plymouthd ; sudo plymouth --show-splash ; for ((I=0; I<10; I++)); do sleep 1 ; sudo plymouth --update=test$I ; done ; sudo plymouth --quit