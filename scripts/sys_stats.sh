user=$(whoami)
path=$(pwd)
kern=$(uname -v)
backupdir='/var/backups'
backupfile1='apache2.tar.gz'
backupfile2='mysql.tar.gz'
backupfile3='php.tar.gz'
sourcedir='/etc/apache2'
sourcedir2='/etc/mysql'
sourcedir3='/etc/php'

backup(){
    mkdir -p $backupdir
    tar -czf $backupdir/$backupfile1 $sourcedir
    tar -czf $backupdir/$backupfile2 $sourcedir2
    tar -czf $backupdir/$backupfile3 $sourcedir3
    echo "backup done"
}
showuptime(){
    up=$(uptime -p | cut -c4-)
    cat << EOF
----
This machine has been up for ${up}
----
EOF
}

calculatememory(){
    memorytotal=$(free -m | awk '/m/ {print $2}')
    memoryused=$(free -m | awk '/m/ {print $3}')
   # mem=$("(memoryused / memorytotal) * 100 | bc")
    cat << EOF
    ---
    You have used $memoryused mb of $memorytotal mb
    ---
EOF

}
listallusers(){
    awk -F ":" '{print $1}' /etc/passwd # F to check for text separator
}
printallshells(){
    awk -F "/" '/^\// {print $NF}' /etc/shells # check if line start with / and NF is last field
}


start(){
    cat<< EOF
    ---
    Signed in as $user
    Choose one to continue:
    1. Uptime
    2. Free memory
    3. Backup
    4. List all users
    5. List all shells
    6. Dependencies
    0. Exit
    ---
EOF
    read x

    case $x in
   0)
        exit 0
        ;;
    1)
        showuptime
        start
        ;;
    2)
        calculatememory
        start
        ;;
    3) 
        backup
        start
        ;;
    4) echo "list all usrs "
        listallusers
        start
        ;;
    5) echo "print all shells"
        printallshells
        start
        ;;
    6)
        cat<< EOF
        ---
    Choose dependency to install:
    1. sudo
    2. wget
    3. curl
    4. logrotate
    99. Intall all
    0. Back
    ---
EOF
            read y
            
            case $y in
            0)
                start
                ;;
            1)
                echo "installing sudo"
                apt install sudo -y
                sudo --version
                start
                ;;
            2)
                echo "installing wget"
                apt install wget -y
                wget --version
                start
                ;;
            3)
                echo "installing curl"
                apt install curl -y
                curl --version
                start
                ;;
            4)  
                echo "install logrotate"
                apt install logrotate -y
                logrotate --version
                start
                ;;
            5)
                sudo apt-get update
                sudo apt install apt-utils -y
                sudo apt install systemctl -y
                sudo apt-get install net-tools -y
                sudo apt-get install docker.io -y
                sudo systemctl start docker
                
                start
                ;;
            99)
                echo "installing all dependencies"
                apt install sudo wget curl logrotate -y
                sudo --version
                wget --version
                curl --version
                logrotate --version
                start
                ;;
            *)
                start
                ;;
            
         esac
         ;;
    *)
        start
        ;;
    
    esac
}

start
