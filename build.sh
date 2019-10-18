#!/bin/bash
BASE_IMAGE=docker://docker.io/phusion/baseimage:0.11

HERE=$(cd $(dirname $0) && echo $PWD)
set -e -x

# Create directories needed for caching
while read dirname; do
    mkdir -p $HERE/$dirname
done <<DIRs
    root/artifacts
    var/lib/apt/lists
    var/cache/apt/archives
DIRs

# Start building image:
ctr=$(buildah from --name warsaw-banking --pull $BASE_IMAGE)
mnt=$(buildah mount $ctr)

# Add file structure from `fs` to the image root
buildah copy --chown root:root $ctr $HERE/fs

# Mount into the image the root home and directories that contain caches used by the installation
VOLUMES="\
    -v $HERE/root:/root \
    -v $HERE/var/lib/apt/lists:/var/lib/apt/lists \
    -v $HERE/var/cache/apt/archives:/var/cache/apt/archives \
"

buildah run $VOLUMES --net=host $ctr -- /root/install.sh
buildah run $VOLUMES $ctr -- /sbin/my_init -- /root/savecert.sh
buildah run $ctr -- rm /var/lib/syslog-ng/syslog-ng.ctl
# TODO: perhaps clean up `/var/lib` or `/var/log` directories (or mount a volume over them as well)

buildah config \
    --workingdir /home/ubuntu \
    --entrypoint '["/sbin/my_init", "--", "/sbin/setuser", "ubuntu"]' \
    --cmd bash \
    $ctr

buildah commit --squash $ctr warsaw-banking
