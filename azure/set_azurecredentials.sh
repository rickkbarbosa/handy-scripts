#!/bin/bash
#===============================================================================
# IDENTIFICATION DIVISION
#        ID SVN:   $Id$
#          FILE:  set_azurecredentials.sh 
#         USAGE:  $0
#   DESCRIPTION:  Set default credentials to AZ Cli
#       OPTIONS:  --- 
#  REQUIREMENTS:  az cli (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) 
#          BUGS:  --- 
#         NOTES:  Developed to be evocated by a .env script (append it as ". /where-is/set_awscredentials.sh" in order to export variables correctly)
#          TODO:  --- 
#        AUTHOR:  Rickk Barbosa 
#       COMPANY:  ---
#       VERSION:  1.0 
#       CREATED:  2020-01-06 15:00 BRT
#      REVISION:  --- 
#=============================================================================== 

#Getting home directory
HOMEDIR=$(eval echo "~$(whoami ;)")

#Starting script
echo Ativando ambiente $(echo ${PWD##*/};)

#Set Credentials
if [[ -z $AZURE_PASSWORD ]]; then
    read -sp "Please type your Azure password: " AZURE_PASSWORD
fi

#If and TenantID has been declared, the login will use it.
#If not, a single login will happen
if [[ -z $AZURE_TENANT_ID ]]; then
    az login -u "${AZURE_USER}" -p "${AZURE_PASSWORD}" 2>/dev/null
else
    az login --tenant ${AZURE_TENANT_ID} -u "${AZURE_USER}" -p "${AZURE_PASSWORD}" 2>/dev/null
fi

#List All attached subscriptions
if [[ $# -eq 0 ]];  then
    echo "Your subscriptions on this login
         When you want handle on specific subscription (Working with K8S, for example), please type:

         az account set --subscription <SubscriptionId>
    "

    az account list --output table --all
fi

#AZ Devops
if [[ -z $AZURE_DEVOPS_EXT_PAT  ]]; then
    echo ${AZURE_DEVOPS_EXT_PAT} | az devops login --organization https://dev.azure.com/${CLIENTNAME}/
fi