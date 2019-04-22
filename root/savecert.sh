#!/bin/bash
HERE=$(cd $(dirname $0) && echo $PWD)
SERVER_CERT=$HERE/artifacts/servercert.pem
CERT_OVERRIDE=$HERE/artifacts/cert_override.txt

set -e -x

openssl s_client -showcerts -connect 127.0.0.1:30900 </dev/null 2>/dev/null | openssl x509 -outform PEM > $SERVER_CERT
$HERE/.local/bin/firefox-cert-override "127.0.0.1:30900=$SERVER_CERT[U]" > $CERT_OVERRIDE

echo
cat $CERT_OVERRIDE
echo
