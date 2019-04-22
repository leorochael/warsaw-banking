#!/bin/bash

# DOWNLOAD the URLs in the `URLs` "here doc" below into `artifacts/` if each checksum fails, i.e.
# if file is missing or incorrect.
# The checksum files should be in the same directory as this script, named after the last segment of
# the URL (the filename) with a `.sha256` suffix, e.g. `warsaw_setup_64.deb.sha256`.

HERE=$(cd $(dirname $0) && echo $PWD)
set -e -x

while read url; do
    _filename=$(basename $url)
    _shaname=$_filename.sha256
    if ! (cd $HERE && sha256sum -c $_shaname) ; then
        curl --progress-bar "$url" > "$HERE/artifacts/$_filename"
    fi
done <<URLs
    https://cloud.gastecnologia.com.br/gas/diagnostico/warsaw_setup_64.deb
    https://bootstrap.pypa.io/get-pip.py
URLs
