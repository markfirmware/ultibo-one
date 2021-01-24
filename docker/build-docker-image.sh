#!/bin/bash
set -x

docker build -t markformware/ultibo . |& tee build.log
