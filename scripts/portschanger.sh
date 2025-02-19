#!/bin/bash
#change ports from 80 to 8080 for apache2
changeports(){
    sudo sed -i 's/^Listen 80$/[[:space:]]Listen 8080/' /etc/apache2/ports.conf
    sudo sed -i 's/^<VirtualHost \*:80>$/<VirtualHost \*:8080>/' /etc/apache2/sites-available/000-default.conf
    
    
    sudo systemctl restart apache2
}
changeports