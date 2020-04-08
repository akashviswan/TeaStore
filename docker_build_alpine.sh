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

docker build --no-cache=true -t "$registry/teastore-alpine-base"  utilities/tools.descartes.teastore.dockerbasealpine/
perl -i -pe's|.*FROM descartesresearch/|FROM '"$registry"'/|g' services/tools.descartes.teastore.*/Dockerfile*
docker build -t "$registry/teastore-alpine-registry" -f services/tools.descartes.teastore.registry/Dockerfile.alpine services/tools.descartes.teastore.registry/
docker build -t "$registry/teastore-alpine-persistence" -f services/tools.descartes.teastore.persistence/Dockerfile.alpine services/tools.descartes.teastore.persistence/
docker build -t "$registry/teastore-alpine-image" -f services/tools.descartes.teastore.image/Dockerfile.alpine services/tools.descartes.teastore.image/
docker build -t "$registry/teastore-alpine-webui" -f services/tools.descartes.teastore.webui/Dockerfile.alpine services/tools.descartes.teastore.webui/
docker build -t "$registry/teastore-alpine-auth" -f services/tools.descartes.teastore.auth/Dockerfile.alpine services/tools.descartes.teastore.auth/
docker build -t "$registry/teastore-alpine-recommender" -f services/tools.descartes.teastore.recommender/Dockerfile.alpine services/tools.descartes.teastore.recommender/
perl -i -pe's|.*FROM '"$registry"'/|FROM descartesresearch/|g' services/tools.descartes.teastore.*/Dockerfile*

if [ "$push_flag" = 'true' ]; then
  docker push "$registry/teastore-alpine-base"
  docker push "$registry/teastore-alpine-registry"
  docker push "$registry/teastore-alpine-persistence"
  docker push "$registry/teastore-alpine-image"
  docker push "$registry/teastore-alpine-webui"
  docker push "$registry/teastore-alpine-auth"
  docker push "$registry/teastore-alpine-recommender"
fi
