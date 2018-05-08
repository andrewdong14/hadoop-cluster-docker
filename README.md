##Run Hadoop Cluster within Docker Containers


![](https://raw.githubusercontent.com/andrewdong14/hadoop-cluster-docker/master/hadoop-cluster-docker.png)


### Section A: setup a hadoop cluster with 3 nodes

#####1. install the docker and pull docker image

Please make sure you have installed Ubuntu 14.04 or late version on your machine or virtual machine. Please make sure the machine/virtual machine has at least 3GB memory if you want to run a 3-nodes cluster or has at least 5GB if you want to run a 5-nodes cluster.
```
# install these software if you not have them on your machine.
sudo apt-get update
sudo apt-get install git -y
sudo apt-get install curl -y
sudo apt-get install wget -y
sudo wget -qO- https://get.docker.com/ | sh
# get the latest hadoop image.
sudo docker pull zdong/hadoop:latest
```
This docker image zdong/hadoop has included latest Hadoop, Open JDK 1.7 and other necessary software. The details of this [zdong/hadoop docker image](https://hub.docker.com/r/zdong/hadoop/) is defined in [Dockfile](https://raw.githubusercontent.com/andrewdong14/hadoop-cluster-docker/master/Dockerfile).

#####2. clone github repository

Get the scripts for starting docker instances in your local machine.
```
git clone https://github.com/andrewdong14/hadoop-cluster-docker
```

#####3. create hadoop network

```
sudo docker network create --driver=bridge hadoop
```

#####4. start container

```
cd hadoop-cluster-docker
sudo ./start-container.sh
```

**output:**

```
start hadoop-master container...
start hadoop-slave1 container...
start hadoop-slave2 container...
root@hadoop-master:~#
```
- start 3 containers with 1 master and 2 slaves
- you will get into the /root directory of hadoop-master container

#####5. start hadoop

```
./start-hadoop.sh
```
Now, you could access hadoop web monitor from http://yourhostname:50070/ or http://localhost:50070/
#####6. run wordcount

```
./runWC.sh
```

**output**

```
input file1.txt:
Macquarie Ugrad COMP335 S12018

input file2.txt:
Macquarie Ugrad S12018

input file3.txt:
COMP335 Young

input file4.txt:
Macquarie Young Choon Lee

input file5.txt:
S12018 Young Choon

wordcount output:
COMP335 2
Choon   2
Lee     1
Ugrad   2
Macquarie       3
S12018  3
Young   3

```

### Section B: setup a hadoop cluster with arbitrary number of nodes

#####1. pull docker images and clone github repository

do 1~3 like section A

#####2. rebuild docker image

```
sudo ./resize-cluster.sh 5
```
- specify parameter > 1: 2, 3..
- this script just rebuild hadoop image with different **slaves** file, which pecifies the name of all slave nodes


#####3. start container

```
sudo ./start-container.sh 5
```
- use the same parameter as the step 2

#####4. run hadoop cluster

do 5~6 like section A

### Section C: access hadoop to run your own task

#####1. login to master node
After you run section A or B, you can open another another linux terminal to run your tasks.
```
sudo docker exec -it hadoop-master /bin/bash
```

#####2. invoke hadoop
please reference [runWC.sh](https://raw.githubusercontent.com/andrewdong14/hadoop-cluster-docker/master/config/runWC.sh) to learn how to run the hadoop task. You also can check hadoop help:
```
hadoop --help
```
