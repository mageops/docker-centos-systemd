#!/usr/bin/env bash

set -e

echo " * Build container..."

docker build . -t mageops/centos-systemd

echo " * Run container..."

! docker top centos-systemd 2>/dev/null 1>/dev/null || docker kill centos-systemd

docker run \
    --rm \
    --detach \
    --interactive \
    --tty \
    --privileged \
    --publish 322:22 \
    --tmpfs /tmp:exec \
    --name centos-systemd \
        mageops/centos-systemd

echo " * Wait until container is healthy..."

while ! docker ps --filter name=centos-systemd --filter health=healthy --format '{{ .Names }}' | grep centos-systemd >/dev/null; do
    echo " * Status: $(docker ps --filter name=centos-systemd --format '{{ .Status }}')"
    sleep 1s
done

echo " * SSH into the container..."

unset SSH_AUTH_SOCK
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@127.0.0.1 -p 322
