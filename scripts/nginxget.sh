changeports(){
    sudo sed -i 's/^Listen 80$/[[:space:]]Listen 8080/' /etc/apache2/ports.conf
    sudo sed -i 's/^<VirtualHost \*:80>$/<VirtualHost \*:8080>/' /etc/apache2/sites-available/000-default.conf
    sudo systemctl restart apache2
}
cd /usr/local/src
sudo apt install -y build-essential
sudo apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring
sudo apt install -y libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev
wget https://nginx.org/download/nginx-1.26.3.tar.gz
sudo tar -zxvf nginx-1.26.3.tar.gz
cd nginx-1.26.3
# -- binary --mina conf --error log --
#https://stackoverflow.com/questions/47098729/nginx-permission-denied-for-default-user-on-var-log-nginx
sudo ./configure --sbin-path=/usr/local/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-pcre --pid-path=/var/run/nginx.pid --with-http_ssl_module
sudo make
sudo make install   
sudo ln -s /usr/local/sbin/nginx /usr/sbin/nginx
sudo nginx -v
sudo ufw allow 8080
sudo ufw allow 4430
sudo ufw reload
changeports

sudo nginx
