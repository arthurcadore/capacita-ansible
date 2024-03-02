#!/bin/ash
# Author: Arthur Cadore M. Barcella
# Github: arthurcadore

# script for setting up the contianer in alpine linux:
echo "Initializing the container setup script..."

# Start the ssh server
/usr/sbin/sshd &

# Install Libs for Ansible:
apk add --no-cache libxml2
apk add --no-cache libxslt

# Configure Ansible Module to H3C devices:
echo "###################################################################"
echo "installing the ansible module for H3C devices..."
cd /ansible/lib
pwd
python3 setup.py install

echo "###################################################################"
echo "verify the ansible module for H3C devices..."
ansible-doc -M library/ comware_vlan

echo "###################################################################"
echo "displaying the users and SSH access port..."
# display the configured users:
cat /etc/passwd
# display the open ports:
netstat -tuln

# Keep the script running by tailing /dev/null
tail -f /dev/null
