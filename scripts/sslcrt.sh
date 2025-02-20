#!/bin/bash
#this will generate ssl certificate and connect it to apache2
dependencies(){
    sudo apt install openssl -y

}
creetecert(){
    sudo mkdir -p /etc/apache2/ssl
    sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt
    sudo a2enmod ssl
    sudo a2ensite default-ssl
    sudo systemctl restart apache2
    sudo systemctl status apache2
}
dependencies
creetecert