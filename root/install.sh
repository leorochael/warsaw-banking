#!/bin/bash
HERE=$(cd $(dirname $0) && echo $PWD)
set -e -x

# Download needed artifacts
$HERE/download.sh

# We mount a cache directory outside the image, so disable the no-caching policy:
rm /etc/apt/apt.conf.d/docker-clean

# TODO: Uninstall unnecessary packages (ssh, cron?)

apt-get update
echo 'libssl1.1 libraries/restart-without-asking boolean true' | debconf-set-selections
apt-get dist-upgrade -y

# Install warsaw and needed utilities
apt-get install -y netcat python3-distutils gdebi-core libcanberra-gtk-module libcanberra-gtk3-module dbus-x11 firefox xauth
gdebi -n $HERE/artifacts/warsaw_setup_64.deb

# Add the default user
adduser --gecos '' --disabled-password --uid $1 ubuntu

# Install dependencies of `savecert.sh` to `/root`,
# which is a mounted volume from outside the container:
python3 $HERE/artifacts/get-pip.py --no-warn-script-location --user setuptools
$HERE/.local/bin/pip install --user --no-warn-script-location firefox_cert_override
