#!/bin/bash
HERE=$(cd $(dirname $0) && echo $PWD)
BASE_IMAGE=docker://docker.io/phusion/baseimage:0.11
set -e -x
ctr=$(buildah from --name=warsaw-banking --pull $BASE_IMAGE)
mnt=$(buildah mount $ctr)

# Add file structure from `fs` to the image root
buildah copy --chown root:root $ctr $HERE/fs

# Mount the root home and directories that contain caches used by the installation into the image
VOLUMES="\
    -v $HERE/root:/root \
    -v $HERE/var/lib/apt/lists:/var/lib/apt/lists \
    -v $HERE/var/cache/apt/archives:/var/cache/apt/archives \
"

buildah run $VOLUMES $ctr -- ls -l /var/log  # remove me

buildah run $VOLUMES --net=host $ctr -- /root/install.sh

buildah run $VOLUMES $ctr -- /sbin/my_init -- /root/savecert.sh

buildah run $VOLUMES $ctr -- ls -l /var/log  # remove me

buildah config \
    --workingdir /home/ubuntu \
    --entrypoint '["/sbin/my_init", "--", "/sbin/setuser", "ubuntu"]' \
    --cmd bash \
    $ctr

buildah commit --squash $ctr warsaw-banking