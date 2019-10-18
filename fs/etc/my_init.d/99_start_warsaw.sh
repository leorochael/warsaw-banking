#!/bin/bash
set -e
/usr/local/bin/warsaw/core
setuser ubuntu /usr/bin/warsaw start

echo -n "Waiting for warsaw core websocket"
for i in $(seq 100); do
    echo -n .
    if /bin/nc -z 127.0.0.1 30900; then
        echo " OK"
        break
    fi
    sleep 1
done
/bin/nc -v -z 127.0.0.1 30900
