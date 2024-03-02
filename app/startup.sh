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
apk add py-pip
apk add py3-pip
apk add libxml2-dev
apk add libxslt-dev
apk add build-base python-dev py2-pip libffi-dev
pip install --upgrade pip
apk add build-base libffi-dev openssl-dev
pip install textfsm
pip install lxml
pip install ncclient
pip install scp
pip install paramiko
pip install cffi
pip install cryptography
pip install ncclient==0.6.0
pip install pyhpecw7

cp /ansible/namespaces.py /ansible/lib/pyhpecw7/utils/xml/namespaces.py
cp /ansible/namespaces.py /ansible/lib/build/lib/pyhpecw7/utils/xml/namespaces.py

# Keep the script running by tailing /dev/null
tail -f /dev/null





