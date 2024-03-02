#!/bin/ash
# Author: Arthur Cadore M. Barcella
# Github: arthurcadore

# script for setting up the contianer in alpine linux: 

echo "Iniciando Container Ansible..."

# Start the ssh server
/usr/sbin/sshd & 

# display the open ports:
netstat -tuln

# Install Libs for Ansible:
apk add --no-cache libxml2
apk add --no-cache libxslt

# Configure Ansible Module to H3C devices:
python3 /ansible/lib/hpe-cw7-ansible-main/setup.py install

ansible-doc -M library/ comware_vlan