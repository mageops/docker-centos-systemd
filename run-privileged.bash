#!/bin/bash

set -e -x

! docker container inspect centos-systemd 2>/dev/null 1>/dev/null || docker kill centos-systemd

docker run \
    --rm \
    --detach \
    --tty \
    --publish 322:22 \
    --tmpfs /tmp:exec \
    --tmpfs /run \
    --privileged \
    --name centos-systemd \
        mageops/centos-systemd
