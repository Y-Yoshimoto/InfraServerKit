#!/bin/bash
# deployRegistory.sh
docker run -d -p 32000:5000 --restart always --name registry registry:3
# stop and remove the container if it exists
# docker stop registry && docker rm registry