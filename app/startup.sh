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
apk add --no-cache git

# Configure Ansible Module to H3C devices:
python3 /ansible/lib/setup.py install

ansible-doc -M library/ comware_vlan

# Keep the script running by tailing /dev/null
tail -f /dev/null
