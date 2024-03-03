# Ansible Appliance with HPE Comware Libs

### This repository implements the [arthurcadore/ansible-comware](https://hub.docker.com/repository/docker/arthurcadore/ansible-comware) images avaiable on DockerHub.

Prerequisites
Before you begin, ensure you have the following packages installed on your system:

- Git version 2.34.1
- Docker version 24.0.6, build ed223bc
- Docker Compose version v2.21.0

---
### Getting Started:

First, copy the line below and paste on your prompt to clone the repository:

```
git clone https://github.com/arthurcadore/ansible-comware
```
If you don't have installed the package Git yet, do it before try to clone the respository!

Navigate to the project directory:

```
cd ./ansible-comware
```

If you don't have Docker (and Docker-compose) installed on your system yet, it can be installed by run the following commands (Script for Ubuntu 22.04): 

```
./installDocker.sh
```

**If you had to install docker, please remember to reboot you machine to grant user privileges for docker application.** 

In sequence, configure the environment files for the application container, you can do this by edditing the following files: 


#### app/Dockefile -> Change SSH user and Password:
```
# add user "ansible" on container
RUN useradd -m -s /bin/bash ansible 

# change the password of user "ansible" to "capacita123"
RUN echo "ansible:capacita123" | chpasswd
```


#### config/hosts -> add new hosts domain names (optional):
```
10.1.1.1 sw1
10.1.1.2 sw2
10.1.1.3 sw3
```
#### by default it comes with the custom domains above, remove it if you have an DNS server for domain resolution.

#### playbook/switch.yaml -> add the playbook configuration you want to be applied on device, like the configuration below:

```
---
- name: Configure VLANs and interfaces on Intelbras Switch
  hosts: switches
  gather_facts: no
  connection: network_cli

  tasks:
    - name: ensure VLAN 10 exists
      comware_vlan: vlanid=10 name=VLAN10 descr=LOCAL_SEGMENT username={{ username }} password={{ password }} hostname={{ inventory_hostname }}
```
#### you can add any other playbook archives if you want to the directory `/playbooks`. 

#### inventory/hosts.yaml -> configure the devices paramters as user, password and other parameters. 
```
all:
  children:
    switches:
      hosts:
        sw1:
          ansible_host: 10.1.1.1
          username: ansible
          password: capacita123
```
#### you can add any other hosts archives if you want to the directory `/inventory`. 


### Start Application's Container: 
Run the command below to start docker-compose file: 

```
docker compose up & 
```
The "&" character creates a process id for the command inputed in, with means that the container will not stop when you close the terminal. 

---

### Access Application:

Once the container is up and running, you can access the container by ssh://127.0.0.1:2000 (2000/TCP port is the default SSH port as defined in the docker-compose.yml file)

---
### Appling a playbook to the devices: 

```
[root@ansibleserver ansible]# ansible-playbook -i /ansible/inventory/hosts.yaml /ansible/playbook.yaml

PLAY [VLAN Automation with Ansible on HP Com7 Devices] ***********************************************

TASK [ensure VLAN 10 exists] *************************************************************************
changed: [sw1]

PLAY RECAP *******************************************************************************************
sw1                      : ok=1    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

--- 
### Stop Container: 
To stop the running container, use the following command:

```
docker-compose down
```

This command stops and removes the containers, networks, defined in the docker-compose.yml file.

--- 



