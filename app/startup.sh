#!/bin/ash
# Author: Arthur Cadore M. Barcella
# Github: arthurcadore

# script for setting up the contianer in alpine linux: 

echo "Iniciando Container Ansible..."

# Start the ssh server
/usr/sbin/sshd & 

# Configure Ansible Module to H3C devices:
python3 /ansible/lib/hpe-cw7-ansible-main/setup.py

# display the open ports:
netstat -tuln

# Keep the script running by tailing /dev/null
tail -f /dev/null