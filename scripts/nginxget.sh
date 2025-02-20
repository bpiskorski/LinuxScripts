#!/bin/bash
apports=$(/etc/apache2/ports.conf)
apvhost=$(/etc/apache2/sites-available/000-default.conf)
#https://www.alibabacloud.com/blog/how-to-build-nginx-from-source-on-ubuntu-20-04-lts_597793
changeports(){
    sudo sed -i 's/^Listen 80$/[[:space:]]Listen 8080/' apports
    sudo sed -i 's/^<VirtualHost \*:80>$/<VirtualHost \*:8080>/' apvhost
    sudo systemctl restart apache2
}
installdependencies(){
    sudo apt install -y build-essential
    sudo apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring
    sudo apt install -y libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev
}
installnginx(){
    wget https://nginx.org/download/nginx-1.26.3.tar.gz
    sudo tar -zxvf nginx-1.26.3.tar.gz
    cd nginx-1.26.3
    sudo ./configure --sbin-path=/usr/local/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-pcre --pid-path=/var/run/nginx.pid --with-http_ssl_module
    sudo make
    sudo make install
    sudo ln -s /usr/local/sbin/nginx /usr/sbin/nginx
    sudo nginx -v
}
firewallallow(){
    sudo ufw allow 8080
    sudo ufw allow 80
    sudo ufw reload
}
start(){
    cat<< EOF
    ---
    Choose one to continue:
    1. Install dependencies
    2. Install nginx
    3. Change ports
    4. Allow ports 8080 and 80
    5. Start nginx
    0. Exit
    ---
EOF
    read x

    case $x in

    0)
        exit 0
        ;;
    1)
        installdependencies
        start
        ;;
    2)
        installnginx
        start
        ;;
    3)
        changeports
        start
        ;;
    4)
        firewallallow
        start
        ;;
    5)
        sudo nginx
        start
        ;;
    esac
}
start
