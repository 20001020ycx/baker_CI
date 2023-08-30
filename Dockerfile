
FROM ubuntu:20.04

# define a variable at build time
ARG HOST_OS=linux

# token to configure with github connection
ARG TOKEN

# Prevents prompts from asking questions during package installation
ENV DEBIAN_FRONTEND=noninteractive 

# Install necessary packages
# -y automatically answers yes to all prompts
RUN apt-get update && apt-get install -y \
    g++ \
    git \
    cmake \
    make \
    ninja-build \ 
    wget \ 
    vim \
    python3 \ 
    curl 

# Copy the entrypoint script into the image
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+rx /entrypoint.sh

# set user of the docker after installing all dependencies using root
ARG DOCKER_USER=baker_CI
ENV DOCKER_USER "$DOCKER_USER"
RUN useradd -ms /bin/bash "$DOCKER_USER"
USER "$DOCKER_USER"

# WORKDIR will create the directory if it does not exist. If exist, cd to WORKDIR
WORKDIR /home/actions-runner
# Download github workflow connection set up
RUN if [ "$HOST_OS" = "linux" ]; then \
        echo "TO BE TESTED" && \
        curl -o actions-runner-linux-x64-2.308.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.308.0/actions-runner-linux-x64-2.308.0.tar.gz && \
        echo "9f994158d49c5af39f57a65bf1438cbae4968aec1e4fec132dd7992ad57c74fa  actions-runner-linux-x64-2.308.0.tar.gz" | shasum -a 256 -c && \
        tar xzf ./actions-runner-linux-x64-2.308.0.tar.gz && \
        # Create the runner and start the configuration experience
        ./config.sh --unattended --url https://github.com/20001020ycx/clp --token "$TOKEN";  \
    elif [ "$HOST_OS" = "macos" ]; then \
        echo "Running on mac" && \ 
        curl -o actions-runner-osx-arm64-2.308.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.308.0/actions-runner-osx-arm64-2.308.0.tar.gz && \
        echo "a8b2c25868e4296cbd203342754223dd2cc17f91585592c99ccd85b587d05310  actions-runner-osx-arm64-2.308.0.tar.gz" | shasum -a 256 -c && \
        tar xzf ./actions-runner-osx-arm64-2.308.0.tar.gz && \
        ./config.sh --unattended --url https://github.com/20001020ycx/clp --token "$TOKEN";  \
    fi

# commands that will be executed when a container is run from the resulting image
ENTRYPOINT ["/entrypoint.sh"]
