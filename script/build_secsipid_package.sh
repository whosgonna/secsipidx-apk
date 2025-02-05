#!/bin/sh

ALPINE_VERSION=$(cat /etc/os-release | grep VERSION_ID | sed -e 's/VERSION_ID=\(\d*\.\d*\).*/v\1/')

PACKAGECLOUD_USER=${PACKAGECLOUD_USER:-whosgonna}
PACKAGECLOUD_REPO=${PACKAGECLOUD_REPO:-`uname -m`}
PACKAGECLOUD_FULL=${PACKAGECLOUD_USER}/${PACKAGECLOUD_REPO}/alpine/${ALPINE_VERSION}


abuild -r


if [ ! -z "$DOT_PACKAGECLOUD" ]; then
    echo $DOT_PACKAGECLOUD > ~/.packagecloud
    printf "\n\nPushing to package cloud repo ${PACKAGECLOUD_FULL}"
    package_cloud push --skip-duplicates ${PACKAGECLOUD_FULL} \
        /home/builder/packages/builder/`uname -m`/*.apk
fi

