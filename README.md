# Ansible Appliance with H3C Comware Libs

### This repository implements the [ansible-comware](https://hub.docker.com/repository/docker/arthurcadore/ansible-comware) images avaiable on DockerHub.

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

  - name: Configuration for H3C devices from Capacita repository
    hosts: sw1
    gather_facts: no
    connection: local

    tasks:
      - name: Creating VLAN 123 on the device
        comware_vlan: vlanid=123 name=VLAN123 descr=VLAN-123-DATA state=present username={{ username }} password={{ password }} hostname={{ inventory_hostname }}

      - name: Creating VLAN 20 on the device
        comware_vlan: vlanid=20 name=VLAN20 descr=VLAN-20-MANAGE state=present username={{ username }} password={{ password }} hostname={{ inventory_hostname }}

      - name: Removing VLAN 10 on the device
        comware_vlan: vlanid=10 state=absent username={{ username }} password={{ password }} hostname={{ inventory_hostname }}

      - name: Configuring this interfaces with "no switchport" (routed) option
        comware_interface: name={{ item }} type=routed username={{ username }} password={{ password }} hostname={{ inventory_hostname }}
        with_items:
          - Ten-GigabitEthernet2/0/12
          - Ten-GigabitEthernet2/0/17
```
#### you can add any other playbook archives if you want to the directory `/playbooks`. 

#### inventory/hosts.yaml -> configure the devices paramters as user, password and other parameters. 
```
all:
  children:
    switches:
      hosts:
        sw1:
          ansible_host: 10.100.29.123
          username: ansible
          password: capacita#123
        sw2:
          ansible_host: 10.100.29.124
          username: ansible2
          password: capacita#1232
        sw3:
          ansible_host: 10.100.29.125
          username: ansible3
          password: capacita#1233
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
root@f6adc83abd94:/# ansible-playbook -i ansible/inventory/hosts ansible/playbooks/switch.yaml

PLAY [Configuration for H3C devices from Capacita repository] ***********************************************************************************************

TASK [Creating VLAN 123 on the device] **********************************************************************************************************************
[WARNING]: Module did not set no_log for password
changed: [sw1]

TASK [Creating VLAN 20 on the device] ***********************************************************************************************************************
changed: [sw1]

TASK [Removing VLAN 10 on the device] ***********************************************************************************************************************
ok: [sw1]

TASK [Configuring this interfaces with "no switchport" (routed) option] *************************************************************************************
ok: [sw1] => (item=Ten-GigabitEthernet2/0/12)
ok: [sw1] => (item=Ten-GigabitEthernet2/0/17)

TASK [Change the configuration of "Ten-GigabitEthernet2/0/11"] **********************************************************************************************
ok: [sw1] => (item=Ten-GigabitEthernet2/0/11)

TASK [Configuring a new IP address on the interface "Ten-GigabitEthernet2/0/12"] ****************************************************************************
ok: [sw1]

TASK [Configuring a new IP address on the interface "Vlan-interface60"] *************************************************************************************
ok: [sw1]

TASK [Saving the configuration on the device...] ************************************************************************************************************
changed: [sw1]

PLAY RECAP **************************************************************************************************************************************************
sw1                        : ok=8    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

---
### Configuring connection to the device manually: 

First, access the python3 prompt using `python3` command:
```
[root@demo]# python3
Python 3.10.12 (main, Nov 20 2023, 14:14:05) [GCC 11.4.0] on linux
```

In python prompt, import comware 7 ansible library using the command below:  
```
>>> from pycw7.comware import COM7
```

In sequence, create an vector with all parameters for login on the device, as displayed below: 
```
>>> accessvalues = dict(host='sw1', username='ansible', password='capacita#123', port=830)
```

Once the vector is created, create an object `device` using the COM7 library passing the access vector on:  
```
>>> device = COM7(**accessvalues)
```

In sequence, open a communication channel with the device using: 
```
>>> device.open()
<ncclient.manager.Manager object at 0x7f3ed5953150>
```

#### To test it, we can get a vlan configuration using `vlan.comware` submodule: 

First, we need to import the feature to the prompt line, to do that, we can use: 
```
>>> from pycw7.features.vlan import Vlan
```

In sequence, with `Vlan` feature loaded, we'll pass the device and VID agrs as parameters to the feature function: 
```
>>> vlan20 = Vlan(device,'20') 
```

Finishing, we'll call the function `get_config()`, to verify the VID20 on the device:  
```
>>> vlan20.get_config()
```

The result for this call is displayed below: 
```
{'vlanid': '20', 'name': 'VLAN20', 'descr': 'VLAN-20-MANAGE'}
```

--- 
### Stop Container: 
To stop the running container, use the following command:

```
docker-compose down
```

This command stops and removes the containers, networks, defined in the docker-compose.yml file.

--- 

# References/Libs used: 

[Base image (ubuntu:22.04) used ](https://hub.docker.com/_/ubuntu)

[Comware HPE lib used](https://github.com/H3C/pycw7-ansible)


