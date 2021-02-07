#!/bin/bash
set -x

docker build -t markformware/ufpc . |& tee build.log
