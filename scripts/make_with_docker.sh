#!/bin/sh

if [ -z $(docker images -q "eams-linux-build:latest" 2> /dev/null) ]; then
  docker build -t "eams-linux-build:latest" scripts/
fi

docker run --rm -it -v $(pwd):/eams-linux/ "eams-linux-build:latest" \
  sh -c "cd /eams-linux/ && make $1 eams-linux.iso && chown -R $(id -u):$(id -g) /eams-linux/"

