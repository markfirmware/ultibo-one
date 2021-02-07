#!/bin/bash

set -e
mkdir -p github.com/ultibohub
cd github.com/ultibohub
git clone https://github.com/ultibohub/Examples
cd Examples

INCLUDES=-Fi/root/ultibo/core/fpc/source/packages/fv/src

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
     @/root/ultibo/core/fpc/bin/$3 \
     *.lpr
    set +x
    if [ "$?" != 0 ]
    then
        exit 1
    fi
}

function build-QEMU {
    if [[ -d QEMU ]]
    then
        pushd QEMU
            build QEMU "-CpARMV7A -WpQEMUVPB" qemuvpb.cfg
        popd
    fi
}

function build-RPi {
    if [[ -d RPi ]]
    then
        pushd RPi
            build RPi "-CpARMV6 -WpRPIB" rpi.cfg
        popd
    fi
}

function build-RPi2 {
    if [[ -d RPi2 ]]
    then
        pushd RPi2
            build RPi2 "-CpARMV7A -WpRPI2B" rpi2.cfg
        popd
    fi
}

function build-RPi3 {
    if [[ -d RPi3 ]]
    then
        pushd RPi3
            build RPi3 "-CpARMV7A -WpRPI3B" rpi3.cfg
        popd
    fi
}

for EXAMPLE in [0-9][0-9]-*
do
    pushd $EXAMPLE
        echo
        echo $Example
        build-QEMU
        build-RPi
        build-RPi2
        build-RPi3
    popd
done
