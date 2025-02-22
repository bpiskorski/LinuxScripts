#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install ansible -y

ansible --version
<<comment
#SSH Access
sudo apt install openssh-server -y
sudo systemctl start ssh
sudo systemctl enable ssh
#Generate SSH Key
ssh-keygen -t rsa -b 2048 
ssh-copy-id root@172.19.0.2
chmod 600 ~/.ssh/authorized_keys
#Test SSH
ssh root@172.19.0.2
comment

# add hosts to sudo nano /etc/ansible/hosts
cat /etc/ansible/hosts
ansible all -m ping
ansible all -a "ls -la"