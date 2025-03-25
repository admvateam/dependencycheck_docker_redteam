#!/bin/bash

# Script that starts the Docker Containers from the server 

#if [ -f "./$0.pid" ] ; then
#	exit
#else
#	echo $$ >$0.pid
#fi

date

echo "Starting docker containers at $(date)"

echo ""

# Starts Docker Container on system start
docker start xxxxxxx

echo ""

# Starts Docker Container on system start
docker start xxxxxxx

echo ""

# Shows the list of Containers that are currently running
docker ps

#rm -fr ./$0.pid