#!/bin/bash
openssl s_client -showcerts -connect 127.0.0.1:30900 </dev/null 2>/dev/null|openssl x509 -outform PEM > /root/artifacts/servercert.pem
