#!/bin/bash
push_flag='true'
registry='akashviswan'

print_usage() {
  printf "Usage: docker_build.sh [-p] [-r REGISTRY_NAME]\n"
}

while getopts 'pr:' flag; do
  case "${flag}" in
    p) push_flag='true' ;;
    r) registry="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

docker build --no-cache=true -t "$registry/teastore-ubuntu-base"  utilities/tools.descartes.teastore.dockerbaseubuntu/
perl -i -pe's|.*FROM descartesresearch/|FROM '"$registry"'/|g' services/tools.descartes.teastore.*/Dockerfile*
docker build -t "$registry/teastore-ubuntu-registry" -f services/tools.descartes.teastore.registry/Dockerfile.ubuntu services/tools.descartes.teastore.registry/
docker build -t "$registry/teastore-ubuntu-persistence" -f services/tools.descartes.teastore.persistence/Dockerfile.ubuntu services/tools.descartes.teastore.persistence/
docker build -t "$registry/teastore-ubuntu-image" -f services/tools.descartes.teastore.image/Dockerfile.ubuntu services/tools.descartes.teastore.image/
docker build -t "$registry/teastore-ubuntu-webui" -f services/tools.descartes.teastore.webui/Dockerfile.ubuntu services/tools.descartes.teastore.webui/
docker build -t "$registry/teastore-ubuntu-auth" -f services/tools.descartes.teastore.auth/Dockerfile.ubuntu services/tools.descartes.teastore.auth/
docker build -t "$registry/teastore-ubuntu-recommender" -f services/tools.descartes.teastore.recommender/Dockerfile.ubuntu services/tools.descartes.teastore.recommender/
perl -i -pe's|.*FROM '"$registry"'/|FROM descartesresearch/|g' services/tools.descartes.teastore.*/Dockerfile*

if [ "$push_flag" = 'true' ]; then
  docker push "$registry/teastore-ubuntu-base"
  docker push "$registry/teastore-ubuntu-registry"
  docker push "$registry/teastore-ubuntu-persistence"
  docker push "$registry/teastore-ubuntu-image"
  docker push "$registry/teastore-ubuntu-webui"
  docker push "$registry/teastore-ubuntu-auth"
  docker push "$registry/teastore-ubuntu-recommender"
fi
