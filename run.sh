#!/bin/bash
set -x
podman run --rm -ti \
    -v /dev/shm:/dev/shm \
    -v /tmp:/tmp \
    --net=host \
    --env=DISPLAY \
    --env=XAUTH_COOKIE="$(bash -c 'echo $2' $(xauth list $DISPLAY|head -1))" \
    warsaw-banking
