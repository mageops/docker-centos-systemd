[![Docker Hub Build Status](https://img.shields.io/docker/cloud/build/mageops/centos-systemd?label=Docker+Image+Build)](https://hub.docker.com/r/mageops/centos-systemd/builds)

# systemd-enabled CentOS 7 Docker container

Image for running CentOS 7 in a docker desktop container (for local dev and provisioning testing)


## Privileged

```
docker run \
    --rm \
    --detach \
    --interactive \
    --tty \
    --publish 322:22 \
    --tmpfs /run:exec \
    --tmpfs /tmp:exec \
    --privileged \
    --name centos-systemd \
        mageops/centos-systemd
```

## Unprivileged

Mount host's read-only `/sys/fs/cgroup` - it's needed for systemd to function at all.

```
docker run \
    --rm \
    --detach \
    --interactive \
    --tty \
    --publish 322:22 \
    --tmpfs /tmp:exec \
    --tmpfs /run \
    --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --name centos-systemd \
        mageops/centos-systemd
```