#!/bin/bash

# Licensed Materials - Property of IBM
# (C) Copyright IBM Corp. 2018. All Rights Reserved.
# US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.

if ! [ $# -eq 4 ] ;  then
  echo "Requires four parameters: the image name you want, the tag you want, the Dockerhub ID, the repository name, the Dockerfile to use."
  echo "E.g. ./BuildAndPushDockerhub.sh icp-nodejs-sample-amd64 1.0.0 ibmcom docker-6/Dockerfile"
  exit;
fi

echo "Cleaning up: removing any existing Node.js image..."
docker rmi -f ibmcom/ibmnode > /dev/null 2>&1
docker rmi -f node > /dev/null 2>&1
rm -rf ./node_modules

echo "WARNING: THIS WILL PUSH TO DOCKERHUB after authenticating, pausing for five seconds first."
sleep 5

image_name=$1
tag=$2
docker_id_user=$3
file_to_use=$4

echo "Image name is: ${image_name}"
echo "Tag is: ${tag}"
echo "Docker ID is ${docker_id_user}"
echo "File to use is: ${file_to_use}"

if [[ ${docker_id_user} == "ibmcom" ]] ; then
  echo "Using ibmrt ID"
  docker login -u ibmrt
else
  docker login -u ${docker_id_user}
fi

if [ $? -ne 0 ]; then
  echo "Didn't login successfully, bailing"; exit;
fi

echo "Docker building..."
docker build -f ${file_to_use} -t ${image_name}:${tag} .

if [ $? -ne 0 ]; then
  echo "Didn't build your application successfully, bailing"; exit;
fi

echo "Docker tagging..."
docker tag ${image_name}:${tag} ${docker_id_user}/${image_name}:${tag}
if [ $? -ne 0 ]; then
  echo "Didn't tag your image successfully, bailing"; exit;
fi

echo "Docker pushing..."
docker push ${docker_id_user}/${image_name}:${tag}
if [ $? -ne 0 ]; then
  echo "Didn't push your image successfully, bailing"; exit;
fi

echo "Done!"
