#!/bin/bash
## Check argument.
if [ $# -ne 1 ]; then
  echo "usage: convertfavicon.sh hoge.png" 1>&2
  exit 1
fi
# Check File
if [ ! -e $1 ]; then
  echo "File not exists."
  exit 1
fi
## Check Image.
images=`docker images | grep faviconmaker | wc -l| awk '{print $1}'`
if [ $images -eq 0 ]; then
    docker-compose build
fi
docker-compose run --rm faviconmaker $1