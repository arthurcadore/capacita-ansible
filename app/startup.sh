#!/bin/bash
# Author: Arthur Cadore M. Barcella
# Github: arthurcadore

# script for setting up the contianer in alpine linux:
echo "Initializing the container setup script..."

# Verify the installed packages for comware ansible module:
echo "verify the ansible module for H3C devices..."
ansible-doc -M library/ comware_vlan

# create the ssh keys for the container and start the ssh service:
ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ""
ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ""
/usr/sbin/sshd &

echo "###################################################################"
echo "displaying the users list and SSH access port..."

# display the open ports:
netstat -tuln

# display the configured users:
cat /etc/passwd

# Keep the script running by tailing /dev/null
tail -f /dev/null
