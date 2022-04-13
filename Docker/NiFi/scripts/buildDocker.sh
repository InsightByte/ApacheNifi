#!/bin/bash

DOCKER_UID=1000
if [ -n "$1" ]; then
  DOCKER_UID="$1"
fi

DOCKER_GID=1000
if [ -n "$2" ]; then
  DOCKER_GID="$2"
fi

MIRROR=https://archive.apache.org/dist
if [ -n "$3" ]; then
  MIRROR="$3"
fi

DOCKER_IMAGE="$(egrep -v '(^#|^\s*$|^\s*\t*#)' nifiVersion.txt)"
NIFI_IMAGE_VERSION="$(echo $DOCKER_IMAGE | cut -d : -f 2)"
echo "Building NiFi Image: '$DOCKER_IMAGE' Version: $NIFI_IMAGE_VERSION Mirror: $MIRROR"
docker build --build-arg UID="$DOCKER_UID" --build-arg GID="$DOCKER_GID" --build-arg NIFI_VERSION="$NIFI_IMAGE_VERSION" --build-arg MIRROR="$MIRROR" -t $DOCKER_IMAGE .
