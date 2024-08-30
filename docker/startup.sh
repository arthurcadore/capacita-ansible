#!/bin/bash
# Author: Arthur Cadore M. Barcella
# Github: arthurcadore

echo "###################################################################"
echo "Booting the H3C comware library..."

cd /ansible/
python3 setup.py install

echo "###################################################################"
echo "Execute playbooks script..."

chmod +x /ansible/playbooks/playbooks.sh
/ansible/playbooks/playbooks.sh
