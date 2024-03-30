# rampant-ide

Neovim as an IDE within a docker container.

## Setup

1. Build image from Dockerfile
    ```bash
    docker build -t rampant-ide .
    ```
2. Run the image **run nvim and let plugins update**
    ```bash    
    docker run -it rampant-ide
    ```
3. Commit the continer to a new image
    ```bash
    docker commit <ID> rampant-ide:latest
    ```

## Usage (Single Container)

1. Create a docker volume
    ```bash
    docker volume create myproject_volume
    ```
2. Mount the volume to the container
    ```bash
    docker run -it --rm -v myproject_volume:/path/in/container rampant-ide
    ```

## Usage (Multi Container)

1. Create a docker-compose.yml config
    ```yaml
    version: '3'

    services:
      neovim:
        image: rampant-ide:latest
        volumes:
          - myproject_volume:/path/in/container
        environment:
          - ENV_VARIABLE=value

    volumes:
      myproject_volume:
    ```

2. Run the development environment
    ```bash
    docker-compose up
    ```


