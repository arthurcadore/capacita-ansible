#!/bin/ash
# Author: Arthur Cadore M. Barcella
# Github: arthurcadore

# script for setting up the contianer in alpine linux:
echo "Initializing the container setup script..."

# Start the ssh server
/usr/sbin/sshd &

# Install Libs for Ansible:
apk add --no-cache libxml2 libxslt

# Configure Ansible Module to H3C devices:
echo "###################################################################"
echo "installing the ansible module for H3C devices..."
cd /ansible/lib
pwd
python3 setup.py install
echo "###################################################################"
echo "verify the ansible module for H3C devices..."
export ANSIBLE_LIBRARY=/ansible/lib/library/
env

echo "###################################################################"
echo "verify the ansible module for H3C devices..."
ansible-doc -M library/ comware_vlan

echo "###################################################################"
echo "displaying the users and SSH access port..."
# display the configured users:
cat /etc/passwd
# display the open ports:
netstat -tuln

echo "###################################################################"
echo "installing dependencies for the HPE CW7 module..."
apk update
apk add --no-cache py-pip py3-pip libxml2-dev libxslt-dev build-base python-dev py2-pip libffi-dev build-base libffi-dev openssl-dev python3-dev git
pip install --upgrade pip
pip install textfsm lxml scp paramiko cffi cryptography ncclient==0.6.0 pyhpecw7

cp /ansible/namespaces.py /ansible/lib/pyhpecw7/utils/xml/namespaces.py
cp /ansible/namespaces.py /ansible/lib/build/lib/pyhpecw7/utils/xml/namespaces.py

# Keep the script running by tailing /dev/null
tail -f /dev/null
