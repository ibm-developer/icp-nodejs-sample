#!/bin/bash

if ! [ $# -eq 3 ] ;  then
  echo "Requires three parameters: the docker user, the docker repository, the architecture it's for. It'll automatically be tagged for 6 and then 8, using the right Dockerfiles for each build."
  echo "E.g. ./PublishChart.sh ibmrt ibmcom amd64"
  exit;
fi

# e.g. ibmrt
docker_user=$1 

# e.g. ibmcom
docker_repo=$2 

# e.g. amd64, s390x, ppc64le
arch=$3 

# e.g. ./BuildAndPushDockerhub.sh icp-nodejs-sample-amd64 1.0.0 ibmcom yourusername docker-6/Dockerfile"

./BuildAndPushDockerhub.sh icp-nodejs-sample-$arch 6 $docker_repo $docker_user docker-6/Dockerfile
./BuildAndPushDockerhub.sh icp-nodejs-sample-$arch 8 $docker_repo $docker_user docker-8/Dockerfile
