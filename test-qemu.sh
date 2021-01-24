#!/bin/bash

set -e
cd github.com/ultibohub/Examples/13-SerialConnection/QEMU

INCLUDES=-Fi/home/gitpod/ultibo/core/fpc/source/packages/fv/src

function build {
    echo ......................... building *.lpr for target $1
    rm -f *.o
    set -x
    fpc \
     -B \
     -Tultibo \
     -O2 \
     -Parm \
     $2 \
     $INCLUDES \
     @/home/gitpod/ultibo/core/fpc/bin/$3 \
     *.lpr
    set +x
    if [ "$?" != 0 ]
    then
        exit 1
    fi
}

build QEMU "-CpARMV7A -WpQEMUVPB" qemuvpb.cfg
qemu-system-arm -m 256M -M versatilepb -cpu cortex-a8 -kernel kernel.bin -display gtk -serial stdio

    