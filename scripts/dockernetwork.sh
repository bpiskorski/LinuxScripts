#!/bin/bash

#docker network create balancer

declare -a arr1
for i in {1..3}
do
    echo "removing container$i"
    docker rm -f container$i
    echo "creating container$i"
    docker run -d --name container$i --network bridge alpine tail -f /dev/null
    docker start container$i

    otp=$(docker exec -it container$i ip addr | grep 'inet ' | awk '{print $2}' | grep -v '127.0.0.1')
    sleep 1   
    arr1+=("$otp")
done

for ((i=0; i<${#arr1[@]}; i++))
do
    echo "Container $((i+1)):"
    echo "${arr1[$i]}"
    echo "======"
    
done

