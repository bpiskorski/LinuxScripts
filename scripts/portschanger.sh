#!/bin/bash
#change ports from 80 to 8080 for apache2
apports=$(/etc/apache2/ports.conf)
apvhost=$(/etc/apache2/sites-available/000-default.conf)
changeports(){
    sudo sed -i 's/^Listen 80$/[[:space:]]Listen 8080/' apports
    sudo sed -i 's/^<VirtualHost \*:80>$/<VirtualHost \*:8080>/' apvhost
    sudo systemctl restart apache2
}
changeports