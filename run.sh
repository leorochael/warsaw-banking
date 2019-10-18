#!/bin/sh
set -x
DOWNLOAD_PATH=$(xdg-user-dir DOWNLOAD)/warsaw-banking
mkdir -p "$DOWNLOAD_PATH"

run_container () {
    podman run --rm -ti \
        -v /dev/shm:/dev/shm -v /tmp:/tmp \
        -v "$DOWNLOAD_PATH":/home/ubuntu/Downloads -v ${XAUTHORITY:-~/.Xauthority}:/home/ubuntu/.Xauthority \
        --env=DISPLAY \
        --uidmap=0:1:999 --uidmap=1000:0:1 --uidmap=1001:1000:64536 \
        --gidmap=0:1:999 --gidmap=1000:0:1 --gidmap=1001:1000:64536 \
        --net=host \
        warsaw-banking "$@"
}

if [ $# -eq 0 ]; then
    run_container firefox --no-remote
else
    run_container "$@"
fi
