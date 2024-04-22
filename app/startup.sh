#!/bin/bash
# Author: Arthur Cadore M. Barcella
# Github: arthurcadore

# set the username value
username="capacita"
# set the username password value
password="capacitassh#pass"

# script for setting up the contianer in alpine linux:
echo "###################################################################"
echo "Initializing the container setup script..."

# Create user/passwd for access the container: 
useradd -m -s /bin/bash "$username"
echo "$username:$password" | chpasswd

# starts ssh service:
ssh-keygen -A
mkdir /run/sshd
/usr/sbin/sshd &

echo "###################################################################"
echo "Booting the H3C comware library..."

python3 /ansible/library/setup.py install

echo "###################################################################"
echo "displaying the users list and SSH access port..."

# display the open ports:
netstat -tuln

# display the configured users:
cat /etc/passwd

# Keep the script running by tailing /dev/null
tail -f /dev/null