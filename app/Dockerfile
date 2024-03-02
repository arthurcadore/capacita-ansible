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

# Install sshpass
RUN apk add --no-cache sshpass


# Copy the "startup.sh" script from the local "./docker/" directory to the container.
RUN mkdir /ansible
COPY app/startup.sh /ansible/startup.sh

# Give executable permissions to the "startup.sh" script to execute.
RUN chmod +x  /ansible/startup.sh

# Mantain container running:
CMD ["/ansible/startup.sh"]
