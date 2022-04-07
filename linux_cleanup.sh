#!/bin/bash

#Package clenup
{
    #When RHEL
    yum autoremove
    yum clean all
} || {
    #When Debian
    apt autoremove -y
    apt-get clean
    apt autoclean
}


#Docker prunning 
if [[ -f $(which docker;) ]]; then 
    docker volume ls -q  | xargs docker volume rm
    docker rmi -f $(docker volume ls -qf dangling=true)
    docker ps -aq | xargs docker rm --volumes
    docker images -aq | xargs docker volume rmi
fi

#Running Logrotate if exists
if [[ -f $(which logrotate;) ]]; then 
    logrotate --force /etc/logrotate.conf
fi

