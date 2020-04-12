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

#docker build --no-cache=true -t "$registry/teastore-debian-base"  utilities/tools.descartes.teastore.dockerbasedebian/
perl -i -pe's|.*FROM descartesresearch/|FROM '"$registry"'/|g' services/tools.descartes.teastore.*/Dockerfile*
#docker build -t "$registry/teastore-debian-registry" -f services/tools.descartes.teastore.registry/Dockerfile.debian services/tools.descartes.teastore.registry/
#docker build -t "$registry/teastore-debian-persistence" -f services/tools.descartes.teastore.persistence/Dockerfile.debian services/tools.descartes.teastore.persistence/
#docker build -t "$registry/teastore-debian-image" -f services/tools.descartes.teastore.image/Dockerfile.debian services/tools.descartes.teastore.image/
#docker build -t "$registry/teastore-debian-webui" -f services/tools.descartes.teastore.webui/Dockerfile.debian services/tools.descartes.teastore.webui/
#docker build -t "$registry/teastore-debian-auth" -f services/tools.descartes.teastore.auth/Dockerfile.debian services/tools.descartes.teastore.auth/
#docker build -t "$registry/teastore-debian-recommender" -f services/tools.descartes.teastore.recommender/Dockerfile.debian services/tools.descartes.teastore.recommender/
perl -i -pe's|.*FROM '"$registry"'/|FROM descartesresearch/|g' services/tools.descartes.teastore.*/Dockerfile*

if [ "$push_flag" = 'true' ]; then
  docker push "$registry/teastore-debian-base"
  docker push "$registry/teastore-debian-registry"
  #docker push "$registry/teastore-debian-persistence"
  #docker push "$registry/teastore-debian-image"
  #docker push "$registry/teastore-debian-webui"
  #docker push "$registry/teastore-debian-auth"
  #docker push "$registry/teastore-debian-recommender"
fi
