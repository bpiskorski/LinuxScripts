user=$(whoami)
date=$(date)
path=$(pwd)
kern=$(uname -v)
memorytotal=$(free -m | awk '/m/ {print $2}')
memoryused=$(free -m | awk '/m/ {print $3}')
showuptime(){
    up=$(uptime -p | cut -c4-)
    cat << EOF
----
This machine has been up for ${up}
----
EOF
}

calculatememory(){
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
    6. intall logrotate
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
        echo "not developed yet"
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
    6) echo "install logrotate"
        apt install logrotate -y
        logrotate --version
        start
        ;;
    *)
        echo "make sure u choose available option"
        ;;
    esac
}

start
