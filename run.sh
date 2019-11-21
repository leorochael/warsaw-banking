#!/bin/bash
set -x
podman run --rm -ti -v /dev/shm:/dev/shm -v /tmp:/tmp --env=DISPLAY --env=XAUTH_COOKIE="$(xauth list $DISPLAY)" --net=host warsaw-banking
