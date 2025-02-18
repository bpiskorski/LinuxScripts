#!/bin/bash#

#backup
createBackup(){
    sudo cp /etc/logrotate.d/apache2 /etc/logrotate.d/apache2.bak
}
restoreBackup(){
    sudo cp /etc/logrotate.d/apache2.bak /etc/logrotate.d/apache2
}
saveVersion(){
    cd /etc/logrotate.d/
    sudo git init
    sudo git add .
    sudo git commit -m "keep previous versions of logrotate config files"
    #sudo git restore apache2
}
#logrotate
createNewConfigFile(){
    sudo touch apache2
    sudo chmod 777 apache2
    sudo echo "/var/log/apache2/access.log /var/log/apache2/error.log {
        daily
        missingok
        rotate 7
        compress
}" > apache2
    sudo chmod 644 apache2
    #sudo chown root:root apache2
    sudo logrotate -f /etc/logrotate.d/apache2
}


start(){
    cat<< EOF
    ---
    Choose one to continue:
    1. Create backup
    2. Restore backup
    3. Save version in git
    4. Create new config file

    0. Exit
    ---
EOF
    read x

    case $x in

    0)
        exit 0
        ;;
    1)
        createBackup
        start
        ;;
    2)
        restoreBackup
        start
        ;;
    3)
        saveVersion
        start
        ;;
    4)  
        createNewConfigFile
        start
        ;;
    esac
}  