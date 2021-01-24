#!/bin/bash
set -x

cp ../build-examples.sh .
docker build -t markformware/ultibo-gitpod -f ultibo-gitpod.dockerfile . |& tee build.log
