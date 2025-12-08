# Docker Deep Dive

This document provides an in-depth look at Docker, a popular platform for developing, shipping, and running applications in containers.

## Table of Contents

1. [What is Docker?](#what-is-docker)
2. [What problems does docker solves](#what-problems-does-docker-solves)
3. [Virtual Machines vs Docker](#virtual-machines-vs-docker)
4. [Docker Architecture](#docker-architecture)
5. [Dockerfile Deep Dive](#dockerfile-deep-dive)
6. [Key Docker Commands](#key-docker-commands)
7. [Docker Networking](#docker-networking)
8. [Docker Volumes and Persistence](#docker-volumes-persistence)
9. [Docker Compose](#docker-compose)

## What is Docker?

Docker is an open-source platform that automates the deployment, scaling, and management of applications using containerization. Containers are lightweight, portable, and self-sufficient units that package an application and its dependencies together, ensuring consistency across different environments.

## What problems does docker solves

Docker addresses several challenges in software development and deployment:

- **Environment Consistency**: Docker ensures that applications run the same way in development, testing, and production environments by packaging all dependencies within containers.
- **Resource Efficiency**: Containers share the host OS kernel, making them more lightweight and efficient than traditional virtual machines.
- **Scalability**: Docker makes it easy to scale applications up or down by adding or removing containers as needed.
- **Isolation**: Each container runs in its own isolated environment, preventing conflicts between applications and improving security.

## Virtual Machines vs Docker

The following table highlights the key differences between Virtual Machines (VMs) and Docker Containers:

| Feature        | Virtual Machines                      | Docker Containers                   |
| -------------- | ------------------------------------- | ----------------------------------- |
| Resource Usage | Heavyweight, requires full OS         | Lightweight, shares host OS kernel  |
| Startup Time   | Minutes                               | Seconds                             |
| Isolation      | Strong isolation with separate OS     | Isolated but shares host OS         |
| Portability    | Less portable due to OS dependencies  | Highly portable across environments |
| Performance    | Slower due to virtualization overhead | Near-native performance             |

![alt text][VMvsDocker]
[VMvsDocker]: https://github.com/PearlThoughtsInternship/Pipeline-Masters/tree/pratyush_nigel_baxla/VMvsDocker.drawio.png "Virtual Machine vs Docker"

## Docker Architecture

Docker's architecture consists of several key components:

- **Docker Engine**: The core component that enables containerization. It includes the Docker daemon, REST API, and CLI.
- **Docker Daemon**: A background service that manages Docker objects such as images, containers, networks, and volumes.
- **Docker CLI**: A command-line interface that allows users to interact with the Docker daemon.
- **Docker Images**: Read-only templates used to create containers. They contain the application code, libraries, and dependencies.
- **Docker Containers**: Lightweight, portable, and self-sufficient units that run applications based on Docker images.
- **Docker Registry**: A storage and distribution system for Docker images. Docker Hub is a popular public registry.

![alt text][Docker Architecture]
[Docker Architecture]: https://github.com/PearlThoughtsInternship/Pipeline-Masters/tree/pratyush_nigel_baxla/DockerArchitecture.png "Docker Architecture"

## Dockerfile Deep Dive

A Dockerfile is a text file that contains a series of instructions to build a Docker image. Here is the step-by-step explaination of my Dockerfile:

```bash
### Uses a lightweight Node.js 22 image (Alpine Linux) as the base.
FROM node:22-alpine

### Installs system packages needed for Strapi plugins like sharp, which processes images.
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git
### Sets the NODE_ENV environment variable to 'development' by default.
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

### Setting the working directory inside the container
WORKDIR /opt/app

### Copying package.json and yarn.lock
To install the dependencies and improves caching as the dependenices only reinstall when these files change:
COPY package.json yarn.lock ./

### Installs node-gyp globally.
Some Strapi plugins (like image processing) require extra system tools to build
RUN yarn global add node-gyp

### Installs project dependencies with an increased network timeout to handle slow connections.
RUN yarn config set network-timeout 600000 -g && yarn install

### Adds the node_modules/.bin directory to the PATH environment variable for easier access to binaries.
ENV PATH=/opt/node_modules/.bin:$PATH

# Copying the full application
COPY . .

### Builds the Strapi application.
RUN ["yarn", "build"]

### Exposes port 1337 for the Strapi application.
EXPOSE 1337

### Sets the default command to start the Strapi application in development mode.
CMD ["yarn", "develop"]
```

## Key Docker Commands

Here are some essential Docker commands for managing containers and images:

- `docker build -t <image_name> .` : Builds a Docker image from a Dockerfile in the current directory, tagging it with the specified name.
- `docker run -d -p <host_port>:<container_port> <image_name>` : Runs a container in detached mode, mapping host port to container port.
- `docker ps` : Lists all running containers.
- `docker stop <container_id>` : Stops a running container.
- `docker rm <container_id>` : Removes a stopped container.
- `docker rmi <image_id>` : Removes a Docker image.
- `docker logs <container_id>` : Fetches the logs of a container.

## Docker Networking

Docker provides several networking options to connect containers:

- **Bridge Network**: The default network driver that allows containers on the same host to communicate.
- **Host Network**: Containers share the host's network stack, providing better performance but less isolation.
- **Overlay Network**: Enables communication between containers across multiple Docker hosts.
- **Macvlan Network**: Assigns a MAC address to a container, making it appear as a physical device on the network.

## Docker Volumes and Persistence

Docker volumes are used to persist data generated by and used by Docker containers. They are stored outside the container's filesystem, ensuring data is not lost when a container is removed. Key commands include:

- `docker volume create <volume_name>` : Creates a new Docker volume.
- `docker run -v <volume_name>:<container_path> <image_name>` : Mounts a volume to a container.
- `docker volume ls` : Lists all Docker volumes.
- `docker volume rm <volume_name>` : Removes a Docker volume.

## Docker Compose

Docker Compose is a tool for defining and running multi-container Docker applications. It uses a YAML file to configure the application's services, networks, and volumes. Key commands include:

- `docker-compose up` : Builds, (re)creates, starts, and attaches to containers for a service.
- `docker-compose down` : Stops and removes containers, networks, and volumes defined in the Compose file.
- `docker-compose ps` : Lists the containers managed by Docker Compose.
- `docker-compose logs` : Fetches the logs of all containers defined in the Compose file.
- `docker-compose build` : Builds or rebuilds services defined in the Compose file.

This concludes the deep dive into Docker. For more information, refer to the [official Docker documentation](https://docs.docker.com/).
