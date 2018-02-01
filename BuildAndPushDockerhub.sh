#!/bin/bash

# Licensed Materials - Property of IBM
# (C) Copyright IBM Corp. 2017. All Rights Reserved.
# US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.

if ! [ $# -eq 5 ] ;  then
  echo "Requires five parameters: the image name you want, the tag you want, the Docker repository to push to, the username to push it as, and the Dockerfile location"
  echo "E.g. ./BuildAndPushDockerhub.sh icp-nodejs-sample-amd64 1.0.0 ibmcom yourusername docker-6/Dockerfile"
  exit;
fi

echo "Warning, this will push to the desired location (e.g. on public Dockerhub!) after authenticating, pausing for five seconds, ensure this is really what you want to do first..."
sleep 5

image_name=$1
image_tag=$2
docker_repository=$3
docker_user=$4
docker_file=$5

echo "Image name will be: ${image_name}"
echo "Image tag will be: ${image_tag}"
echo "Docker user: ${docker_user}"
echo "Docker repository: ${repository}"
echo "File to use: ${file_to_use}"

docker login -u ${docker_id}

if [ $? -ne 0 ]; then
  echo "Didn't login successfully, bailing"; exit;
fi

echo "Building the Docker image"
docker build -t ${image_name}:${tag} .
if [ $? -ne 0 ]; then
  echo "Didn't build your application successfully, bailing"; exit;
fi

echo "Tagging the Docker image"
docker tag ${image_name}:${image_tag} ${docker_user}/${image_name}:${image_tag}
if [ $? -ne 0 ]; then
  echo "Didn't tag your image successfully, bailing"; exit;
fi

echo "Pushing the Docker image"
docker push ${docker_user}/${image_name}:${image_tag}
if [ $? -ne 0 ]; then
  echo "Didn't push your image successfully, bailing"; exit;
fi

echo "Done!"
