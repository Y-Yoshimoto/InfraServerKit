#!/bin/bash
unitd --no-daemon --control unix:/var/run/control.unit.sock &
date >> /www/init.txt

curl -X PUT -d @/www/start.json --unix-socket \
    /var/run/control.unit.sock http://localhost/

taif -f /www/start.json
