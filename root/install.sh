#!/bin/bash
HERE=$(cd $(dirname $0) && echo $PWD)
WARSAW_URL=https://cloud.gastecnologia.com.br/gas/diagnostico/warsaw_setup_64.deb
set -e -x

# We mount a cache directory outside the image, so disable the no-caching policy:
rm /etc/apt/apt.conf.d/docker-clean

# TODO: Uninstall unnecessary packages (SSH)

apt-get update
apt-get dist-upgrade -y

# Install packages
apt-get install -y \
    firefox \
    gdebi-core \
    xdg-user-dirs \

# Install warsaw
gdebi -n $HERE/artifacts/warsaw_setup_64.deb

# Add the default user
adduser --gecos '' --disabled-password ubuntu
# And configure its home folders (esp. ~/Downloads for firefox)
setuser ubuntu xdg-user-dirs-update