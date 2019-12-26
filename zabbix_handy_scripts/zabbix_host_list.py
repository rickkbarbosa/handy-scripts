#!/bin/env python
#Create group-separated host list 

import os
import json
import sys
import json
from zabbix_api import ZabbixAPI

reload(sys)
sys.setdefaultencoding('utf8')

zabbix_server = "http://some.zab.ser.ver"
username = "user"
password = "$3cr3t"

zapi = ZabbixAPI(server=zabbix_server)
zapi.login(username, password)

client_name = zapi.hostgroup.get(        
   { 
     "output": [ "groupid", "name" ],
   } 
)

for i in client_name:
  host_list = zapi.host.get(        
     { 
       "output": [ "hostid", "host" ], 
       "status": 0,
       "groupids": i['groupid']
     } 
  )

  host_ids = []

  for x in host_list:
    host_ids.append(x['hostid'])

  host_ips = zapi.hostinterface.get(
     { 
       "output": [ "ip" ],
       "hostids": host_ids,
       "filter": { "port": 161 }
     } 
  )

  if len(host_list) >0:  
    f = open(i['name'], "w")
    for x in host_ips:
      f.write(x['ip'])
      f.write("\n")
    f.close()