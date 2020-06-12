#!/bin/bash

set -e -x

! docker container inspect centos-systemd 2>/dev/null 1>/dev/null || docker kill centos-systemd

docker build --tag mageops/centos-systemd .

docker run \
    --interactive \
    --tty \
    --publish 322:22 \
    --tmpfs /tmp:exec \
    --tmpfs /run:exec \
    --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --name centos-systemd \
        mageops/centos-systemd
