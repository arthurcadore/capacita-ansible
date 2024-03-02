# Dockerfile: Defines container specifications to startup and run.
# Author: Arthur Cadore M. Barcella
# Github: arthurcadore
# Capacitação Redes - PV Intelbras

FROM alpinelinux/ansible:latest-x86_64

# Install SSH Server
RUN apk add --no-cache openssh-server
RUN ssh-keygen -A

# Create user ansible and set password
RUN adduser -D ansible
RUN echo "ansible:capacita" | chpasswd
RUN cat /etc/passwd

# Install sshpass
RUN apk add --no-cache sshpass

# Install Libs for Ansible:
RUN apk add --no-cache libxml2
RUN apk add --no-cache libxslt

RUN mkdir /ansible

# Copy the "startup.sh" script from the local "./docker/" directory to the container.
COPY app/startup.sh /ansible/startup.sh

# Give executable permissions to the "startup.sh" script to execute.
RUN chmod +x  /ansible/startup.sh

# Starts the container by running the startup.sh script.
CMD ["/ansible/startup.sh"]

