#!/bin/bash
#installing all prerequisits for lamp
apt update
sudo apt install ufw -y #firewall

sudo ufw allow http 
sudo ufw allow 3306
sudo ufw reload

sudo apt install systemctl

sudo apt install apache2 -y
source /etc/apache2/envvars
sudo systemctl start apache2

sudo apt install mysql-server -y
#change sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
#bind address to 0.0.0.0
sudo systemctl start mysql

#mysql -u root #to log in
#mysql -u root -p 123 --protocol=tcp

#php
sudo apt install php libapache2-mod-php php-mysql -y #8, 60 for Warsaw
#sudo nano /etc/apache2/mods-enabled/dir.conf move index.php to first line

#check if running
sudo ufw status
sudo systemctl status mysql
sudo systemctl status mysql