# Dockerfile: Defines container specifications to startup and run.
# Author: Arthur Cadore M. Barcella
# Github: arthurcadore
# Capacitação Redes - PV Intelbras

# Base image:
FROM arthurcadore/ansible-comware:4.0

# add user "ansible" on container
RUN useradd -m -s /bin/bash ansible 

# change the password of user "ansible" to "capacita123"
RUN echo "ansible:capacita123" | chpasswd

# Starts and Mantain container running:
CMD ["/ansible/startup.sh"]