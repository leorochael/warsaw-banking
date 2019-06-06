#!/bin/sh
set -x
podman run --rm -ti --net=host warsaw-banking
