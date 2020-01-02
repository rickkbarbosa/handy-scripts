#/bin/bash
#Shutdown a instance and create a image

RESOURCE_GROUP_NAME="resourcegroup-name"
HOST_NAME="A-NAME"
HOST_IMAGE_NAME="A-IMAGE-NAME"

sudo waagent -deprovision+user

#Desalocar a VM Linux através do comando abaixo via Azure CLI:
az vm deallocate --resource-group ${RESOURCE_GROUP_NAME} --name ${HOST_NAME}

#Generalizar a VM Linux através do comando abaixo via Azure CLI:
az vm generalize --resource-group ${RESOURCE_GROUP_NAME} --name ${HOST_NAME}

#Criar Imagem Linux através da VM que foi desalocada e generalizada:
az image create --resource-group ${RESOURCE_GROUP_NAME} --name IMAGEHUBLOGICALIS2 --source ${HOST_NAME}
