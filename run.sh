#!/bin/sh
set -x
podman run --rm -ti -v /dev/shm:/dev/shm -v /tmp:/tmp --env=DISPLAY --net=host warsaw-banking
