#!/bin/bash

# Script that builds a Docker image and runs a container for DependencyCheck

# Exits immediately if a command exits with a non-zero status
set -e 

# Defines the variables
DC_TAG_NAME="dependency-check-sca"                  			# DependencyCheck Docker Image and Docker Container name
DC_TAG_OS="ubuntu"                                  			# DependencyCheck Base OS used for the Docker Image
DC_DOCKERFILE="./opt/DependencyCheck/dependency-check-sca.dockerfile"   # Path to the Dockerfile to build DependencyCheck Docker Image and Docker Container

# Function to check the success of the last executed command
# Takes an error message as an argument and exits the script if the command failed
check_success() {
    local exit_code=$1
    local message=$2
    if [ $exit_code -ne 0 ]; then
        echo -e "\e[31mError: $message\e[0m"        # Prints the error message in red
        exit $exit_code                             # Exits the script with the captured failure status
    fi
}

# Builds the Docker Image for DependencyCheck
echo "Building the Docker Image '$DC_TAG_NAME:$DC_TAG_OS' for DependencyCheck at $(date)..."

echo ""

docker build --tag "$DC_TAG_NAME:$DC_TAG_OS" --file "$DC_DOCKERFILE" .

echo ""

dc_docker_image_build_status=$?                     # Captures the exit code immediately
check_success $dc_docker_image_build_status "Failed to build the '$DC_TAG_NAME' Docker Image." 

echo ""

# Lists the Docker images and filter by the newly created Docker Image for DependencyCheck
docker images | grep "$DC_TAG_NAME"

echo ""

dc_docker_image_list_status=$?                      # Captures the exit code immediately
check_success $dc_docker_image_list_status "Failed to find the '$DC_TAG_NAME' Docker Image." 
echo -e "\e[33mDocker Image '$DC_TAG_NAME' has been created successfully!\e[0m"

echo ""

# Runs a Docker Container using the newly created Docker Image for DependencyCheck
echo "Running the Docker Container '$DC_TAG_NAME:$DC_TAG_OS' with the recently created Docker Image for DependencyCheck at $(date)..."

echo "" 

docker run -d --name "$DC_TAG_NAME" "$DC_TAG_NAME:$DC_TAG_OS"
dc_docker_run_status=$?                             # Captures the exit code immediately
check_success $dc_docker_run_status "Failed to run '$DC_TAG_NAME:$DC_TAG_OS' Docker Container."

echo ""

# Displays the running Docker Container's ID for confirmation of DependencyCheck Docker container
docker ps -q --filter "name=$DC_TAG_NAME"

echo ""

dc_docker_container_ps_status=$?                                    # Captures the exit code immediately
check_success $dc_docker_container_ps_status "Failed to confirm the running status of the '$DC_TAG_NAME:$DC_TAG_OS' Docker container."
echo -e "\e[33mDocker Container '$DC_TAG_NAME:$DC_TAG_OS' is up and running!\e[0m"

echo ""

# Prints a success message
echo -e "\e[32mExecution completed successfully!\e[0m"

echo ""

# Enters the Docker container cli as root user
echo -e "\e[33mEntering the DependencyCheck Docker Container cli as root user\e[0m"

echo ""

DC_DOCKER_CONTAINER_ID=$(docker ps -q --filter "name=$DC_TAG_NAME")
docker exec -u root -it $DC_DOCKER_CONTAINER_ID /bin/bash