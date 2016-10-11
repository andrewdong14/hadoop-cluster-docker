#!/bin/bash

# the default node number is 3
N=${1:-3}


# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                --name hadoop-master \
                --hostname hadoop-master \
                zdong/hadoop:latest &> /dev/null
 # Here is detail usage for the each parameter
 # run: to run a docker instances
 # -itd:
 #      -i, --interactive                 Keep STDIN open even if not attached
 #      -t, --tty                         Allocate a pseudo-TTY
 #      -d, --detach                      Run container in background and print container ID
 # --net: Connect a container to a network
 # -p: mapping a container's port(s) to the host (default [])
 # --name: Assign a name to the container
 # --hostname: Container host name


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                zdong/hadoop:latest &> /dev/null
	i=$(( $i + 1 ))
done

# get into hadoop master container
sudo docker exec -it hadoop-master bash

# Usage:  docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
# Run a command in a running container#
#   -i, --interactive    Keep STDIN open even if not attached
#   -t, --tty            Allocate a pseudo-TTY
# hadoop-master : container's name
# bash: the command to run
