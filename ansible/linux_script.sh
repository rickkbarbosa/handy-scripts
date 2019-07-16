#!/bin/bash

ZBX_HOME="/var/lib/zabbix"
ZBX_CONFIGDIR="/etc/zabbix"
ZBX_LOG="/var/log/zabbix"
ZBX_PID="/var/run/zabbix/"
SUBSCRIPTION="Test"

yum install -y sysstat wget

#Downloading zabbix client
setenforce 0
wget http://10.130.0.145/zabbix/zabbix-client.tar.gz
tar xvfzp zabbix-client.tar.gz -C /


#Prepare User
/usr/sbin/adduser -d ${ZBX_HOME} -s /bin/bash -c "Zabbix Monitoring System" zabbix

#Prepare zabbix user
chsh -s /bin/bash zabbix
mkdir -p ${ZBX_CONFIGDIR}/zabbix_agentd.d ${ZBX_LOG} ${ZBX_PID}
touch ${ZBX_LOG}/zabbix_agentd.log
chown -R zabbix: ${ZBX_CONFIGDIR} ${ZBX_LOG} ${ZBX_PID}
chmod -R 775 ${ZBX_LOG} ${ZBX_PID}




#Adjusting configfile
sed -i "s/^Hostname=.*/Hostname=$(hostname;)/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s/^\#Hostmetada=.*/Hostmetadata=Linux MAAS e44e84a2048cab0e842b55c2ac14396e4736151ec74a1ab8131b74782bd312b7 $SUBSCRIPTION/g"

#Starting Zabbix Agent
/usr/local/sbin/zabbix_agentd -c ${ZBX_CONFIGDIR}/zabbix_agentd.conf

#Preparing autostart
{ 
    sed -i "s/touch\ \/var\/lock\/subsys\/local/\/usr\/local\/sbin\/zabbix_agentd\ \-c\ \/etc\/zabbix\/zabbix_agentd.conf\ntouch\ \/var\/lock\/subsys\/local/g" /etc/rc.d/rc.local
} || { 
    sed -i "s/touch\ \/var\/lock\/subsys\/local/\/usr\/local\/sbin\/zabbix_agentd\ \-c\ \/etc\/zabbix\/zabbix_agentd.conf\ntouch\ \/var\/lock\/subsys\/local/g" /etc/rc.local
}