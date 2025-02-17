user=$(whoami)
date=$(date)
path=$(pwd)
kern=$(uname -v)

showuptime(){
    up=$(uptime -p | cut -c4-)
    cat << EOF
----
This machine has been up for ${up}
----
EOF
}

start(){
    cat<< EOF
    ---
    Hello {$user}, choose one to continue:
    1. Uptime
    2. Free memory
    3. Backup
    4. Exit
    ---
EOF
    read x

    case $x in
    1)
        showuptime
        ;;
    2)
        free -m
        ;;
    3) 
        echo "not developed yet"
        ;;
    4)
        exit 0
        ;;
    
    *)
        echo "make sure u choose available option"
        ;;
    esac
}

start
