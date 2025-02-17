#!/bin/bash
TAG=''
VERSION_TAG=

case "$TRAVIS_BRANCH" in
  "main") #branch dfault 'main'
    TAG=latest
    VERSION_TAG=$TRAVIS_BUILD_NUMBER #value automtic from travis execution job
    ;;
  "develop")
    TAG=dev
    VERSION_TAG=$TAG-$TRAVIS_BUILD_NUMBER
    ;;    
esac

REPOSITORY=$DOCKER_USERNAME/ms-firstdevops-java

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker build -t $REPOSITORY:$TAG .
docker build -t $REPOSITORY:$VERSION_TAG .
docker push $REPOSITORY:$TAG
docker push $REPOSITORY:$VERSION_TAG