#!/bin/bash

# Licensed Materials - Property of IBM
# (C) Copyright IBM Corp. 2017. All Rights Reserved.
# US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.

if ! [ $# -eq 3 ] ;  then
  echo "Requires three parameters: the image name you want, the tag you want, the Dockerhub ID and the repository name"
  echo "E.g. ./BuildAndPushDockerhub.sh icp-nodejs-sample-amd64 1.0.0 adamroberts"
  exit;
fi

echo "WARNING: THIS WILL PUSH TO DOCKERHUB after authenticating, pausing for five..."
sleep 5

IMAGE_NAME=$1
TAG=$2
export DOCKER_ID_USER=$3

echo "Image name will be: ${IMAGE_NAME}"
echo "Tag will be: ${TAG}"
echo "Docker ID is ${DOCKER_ID_USER}"

# echo "Omitting docker login step - uncomment this part if you're pushing directly to an account"
sleep 3
# Uncomment so we can use a functional ID to push to another repository

#docker login -u ibmrt
docker login -u ${DOCKER_ID_USER}

if [ $? -ne 0 ]; then
  echo "Didn't login successfully, bailing"; exit;
fi

echo "Docker building..."
docker build -t ${IMAGE_NAME}:${TAG} .
if [ $? -ne 0 ]; then
  echo "Didn't build your application successfully, bailing"; exit;
fi

echo "Docker tagging..."
docker tag ${IMAGE_NAME}:${TAG} ${DOCKER_ID_USER}/${IMAGE_NAME}:${TAG}
if [ $? -ne 0 ]; then
  echo "Didn't tag your image successfully, bailing"; exit;
fi

echo "Docker pushing..."
docker push ${DOCKER_ID_USER}/${IMAGE_NAME}:${TAG}
if [ $? -ne 0 ]; then
  echo "Didn't push your image successfully, bailing"; exit;
fi

echo "Done!"
