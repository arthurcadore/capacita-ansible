#!/bin/bash
# Author: Arthur Cadore M. Barcella
# Github: arthurcadore

echo "###################################################################"
echo "Booting the H3C comware library..."

cd /ansible/
python3 setup.py install

echo "###################################################################"
echo "Execute playbooks script..."

chmod +x ./playbooks.sh
./playbooks.sh

# Keep the script running by tailing /dev/null
tail -f /dev/null