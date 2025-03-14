#!/bin/sh

ALPINE_VERSION=${1:-3.21}

echo "ALPINE VERSION IS ${ALPINE_VERSION}"

IMAGE_NAME=secsipid_apk_builder:alpine-${ALPINE_VERSION}

echo "Building ${IMAGE_NAME}"

docker build \
    --no-cache \
    --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
    -t ${IMAGE_NAME} \
    .


docker run  \
    --env-file .env \
    -v ./abuild:/home/builder/.abuild \
    ${IMAGE_NAME} \
    /home/builder/build_secsipid_package.sh




