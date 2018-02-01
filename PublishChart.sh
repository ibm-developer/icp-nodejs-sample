#!/bin/bash

if ! [ $# -eq 1 ] ;  then
  echo "Requires one arg, the arch to build on."
  echo "E.g. ./PublishChart.sh amd64|ppc64le|s390x"
  exit;
fi

arch=$1

# if ibmcom, log in to ibmrt first
./BuildAndPushDockerhub.sh icp-nodejs-sample-$arch 6 ibmcom docker-6/Dockerfile
./BuildAndPushDockerhub.sh icp-nodejs-sample-$arch 8 ibmcom docker-8/Dockerfile
