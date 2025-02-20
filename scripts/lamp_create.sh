#!/bin/bash
#installing all prerequisits for lamp
installdependencies(){
    apt update
    sudo apt install -y build-essential
    sudo apt install ufw -y
    sudo apt install systemctl
}
allowports(){
    sudo ufw allow 80
    sudo ufw allow 3306
    sudo ufw reload
}
installapache(){
    sudo apt install apache2 -y
    source /etc/apache2/envvars
    sudo systemctl start apache2
}
installmysql(){
    sudo apt install mysql-server -y
}
installphp(){
    sudo apt install php libapache2-mod-php php-mysql -y
}
verify(){
    sudo ufw status
    sudo systemctl status mysql
    sudo systemctl restart apache2
    sudo systemctl status apache2

}
installdependencies
allowports
installapache
#bind address to 0.0.0.0
installmysql
#mysql -u root #to log in
#mysql -u root -p 123 --protocol=tcp
installphp
#sudo nano /etc/apache2/mods-enabled/dir.conf move index.php to first line
verify
#change sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf

