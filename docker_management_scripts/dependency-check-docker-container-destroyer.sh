#!/bin/bash

# Script that destroys the Docker Image and Container for DependencyCheck

# Exits immediately if a command exits with a non-zero status
set -e

# Defines the variables
DC_TAG_NAME="dependency-check-sca"                 # DependencyCheck Docker Image and Docker Container name
DC_TAG_OS="ubuntu"                                 # DepencencyCheck Base OS Tag for filtering the Docker Image

# Function to check the success of the last executed command
# Takes an error message as an argument and exits the script if the command failed
check_success() {
    local exit_code=$1
    local message=$2
    if [ $exit_code -ne 0 ]; then
        echo -e "\e[31mError: $message\e[0m"       # Prints the error message in red
        exit $exit_code                            # Exits the script with the captured failure status
    fi
}

# Stops the DependencyCheck Docker Container
echo "Stopping the Docker Container '$DC_TAG_NAME' at $(date)..."

echo ""

DC_CONTAINER_ID=$(docker ps -a -q --filter "name=$DC_TAG_NAME")
if [ -n "$DC_CONTAINER_ID" ]; then
    docker stop "$DC_CONTAINER_ID"
    dc_docker_container_stop_status=$?             # Captures the exit code immediately
    check_success $dc_docker_container_stop_status "Failed to stop the container '$DC_TAG_NAME'."
    
    echo ""

    echo -e "\e[32mDocker Container '$DC_TAG_NAME' has been stopped!\e[0m"
else
    echo -e "\e[33mNo running Docker Container found with the name '$DC_TAG_NAME'.\e[0m"
fi

echo ""

# Removes the DependencyCheck Docker Container
echo "Removing the Docker Container '$DC_TAG_NAME' at $(date)..."

echo ""

if [ -n "$DC_CONTAINER_ID" ]; then
    docker container rm "$DC_CONTAINER_ID"
    dc_docker_container_rm_status=$?               # Captures the exit code immediately
    check_success $dc_docker_container_rm_status "Failed to remove the container '$DC_TAG_NAME'."
    
    echo ""

    echo -e "\e[33mDocker Container '$DC_TAG_NAME' has been removed!\e[0m"
else
    echo -e "\e[33mNo Docker Container found to remove with the name '$DC_TAG_NAME'.\e[0m"
fi

echo ""

# Deletes the DependencyCheck Docker Image
echo "Removing the Docker Image '$DC_TAG_NAME:$DC_TAG_OS' at $(date)..."

echo ""

DC_IMAGE_ID=$(docker images | grep "$DC_TAG_NAME" | grep "$DC_TAG_OS" | awk '{print $3}')
if [ -n "$DC_IMAGE_ID" ]; then
    docker image rm -f "$DC_IMAGE_ID"  
    dc_docker_image_rm_status=$?                   # Captures the exit code immediately
    check_success $dc_docker_image_rm_status "Failed to remove the image '$IMAGE_NAME:$BASE_OS'."
    
    echo ""
    
    echo -e "\e[33mDocker Image '$DC_TAG_NAME:$DC_TAG_OS' has been removed!\e[0m"
else
    echo -e "\e[33mNo Docker Image found with the name '$DC_TAG_NAME:$DC_TAG_OS'.\e[0m"
fi

echo ""

# Prints a success message
echo -e "\e[32mExecution completed successfully!\e[0m"