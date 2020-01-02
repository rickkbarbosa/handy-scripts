#!/bin/bash
#This script removes Azure agents on Linux servers

/usr/sbin/waagent
/opt/omi/bin/omiserver -d
/opt/microsoft/auoms/bin/auoms -d
/opt/omi/bin/omiengine -d --logfilefd 3 --socketpair 9
/opt/microsoft/auoms/bin/auoms
/opt/microsoft/auoms/bin/auomscollect
/usr/sbin/waagent
python3 -u bin/WALinuxAgent-2.2.44-py2.7.egg -run-exthandle

apt remove --purge walinuxagent -y
apt remove --purge omsagent -y
apt remove auoms --purge -y 
