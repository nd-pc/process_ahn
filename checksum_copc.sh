#!/bin/bash

# Process positional arguments.
copcdir=$1

if ! [ -d ${copcdir} ]; then
    echo "Error: COPC directory does not exist."
fi
if [ -f ${copcdir}/copc.md5.chk ]; then
    rm ${copcdir}/copc.md5.chk
fi

# Process the copc.las files in the COPC directory:
# Create a md5 checksum file for the combined files.
md5sum ${copcdir}/*.copc.laz > ${copcdir}/copc.md5.chk

