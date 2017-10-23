#!/bin/bash

# Licensed Materials - Property of IBM
# (C) Copyright IBM Corp. 2017. All Rights Reserved.
# US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.

if ! [ $# -eq 3 ] ;  then
  echo "Requires three parameters: the image name you want, the tag you want, and the registry CA domain"
  echo "E.g. ./BuildAndPushPrivate.sh icp-nodejs-sample-amd64 1.0.0 mycluster.icp"
  exit;
fi

IMAGE_NAME=$1
TAG=$2
CA_DOMAIN=$3

echo "Image name will be: ${IMAGE_NAME}"
echo "Tag will be: ${TAG}"

docker login ${CA_DOMAIN}:8500

if [ $? -ne 0 ]; then
  echo "Didn't login successfully, bailing"; exit;
fi

echo "Docker building..."
docker build -t ${IMAGE_NAME}:${TAG} .
if [ $? -ne 0 ]; then
  echo "Didn't build your application successfully, bailing"; exit;
fi

echo "Docker tagging..."
docker tag ${CA_DOMAIN}:8500/${IMAGE_NAME}:${TAG} ${CA_DOMAIN}:8500/${IMAGE_NAME}:${TAG}
if [ $? -ne 0 ]; then
  echo "Didn't tag your image successfully, bailing"; exit;
fi

echo "Docker pushing..."
docker push ${CA_DOMAIN}:8500/${IMAGE_NAME}:${TAG}
if [ $? -ne 0 ]; then
  echo "Didn't push your image successfully, bailing"; exit;
fi

echo "Done!"
