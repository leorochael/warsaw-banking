#!/bin/sh
set -x
podman run --rm -ti -v /dev/shm:/dev/shm -v /tmp/.X11-unix:/tmp/.X11-unix --env=DISPLAY --net=host warsaw-banking
