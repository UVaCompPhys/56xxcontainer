#!/bin/bash

usage()
{
cat <<!EOF!
Usage: build.sh [-hf] [target]
   -h: print this message and exit
   -f: force rebuild on contianer
   target = name of sif file to build fc42*]
!EOF!
    exit
} >&2

# default build
TAINER=fc42

for arg in "$@"; do
    if [ "$arg" = "-h" ]; then
	usage
    elif [ "$arg" = "-f" ]; then
	FLAG="-F"
	echo "forcing rebuild of container"
    else
        TAINER=${arg%.*} # truncate .def if present
    fi    
done


TGT=${TAINER}.sif
DEF=${TAINER}.def

echo "=== attempting to build $DEF ==="

module load apptainer
apptainer build $FLAG $TGT $DEF
mkdir -p ~/apptainer
ln -sf $PWD/$TGT ~/apptainer/


