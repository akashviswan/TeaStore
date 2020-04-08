### Build Containers

## 1. Multi Stage build
 
  # Use docker files
   docker build --no-cache=true -t akashviswan/teastore-auth -f Dockerfile-ubuntu-auth
   docker build --no-cache=true -t akashviswan/teastore-image -f Dockerfile-ubuntu-image
   docker build --no-cache=true -t akashviswan/teastore-persistance -f Dockerfile-ubuntu-persistance
   docker build --no-cache=true -t akashviswan/teastore-recomendor -f Dockerfile-ubuntu-recomendor
   docker build --no-cache=true -t akashviswan/teastore-registry -f Dockerfile-ubuntu-registry
   docker build --no-cache=true -t akashviswan/teastore-webui -f Dockerfile-ubuntu-webui    
 ## 2. Alpine 
 # 1 Build
        ./docker_build_alpine.sh
 # 2 Run
        docker-compose -f ./examples/docker/docker-compose_default_alpine.yaml up -d
 ## 3. Ubuntu 
         
 # 1 Build
        ./docker_build_ubuntu.sh
 # 2 Run
        docker-compose -f ./examples/docker/docker-compose_default_ubuntu.yaml up -d
 

## Run the TeaStore using Docker Compose
The multiple single container setup is suitable for to be used with Docker Compose as well. One advantage of using docker-compose is the easy setup of internal networks. This allows the services to communicate with each other using hostnames defined as the service name in the docker-compose file.


docker-compose -f ./examples/docker/docker-compose_default.yaml up -d

URL : localhost:8080/tools.descartes.teastore.webui/
