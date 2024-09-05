#!/bin/bash

# Process positional arguments.
copcdir=$1

if ! [ -d ${copcdir} ]; then
    echo "Error: COPC directory does not exist."
fi


# Count the copc.las files in the copc directory.
echo "COPC files in ${copcdir}: $(ls ${copcdir} | grep copc.laz | wc -l)"

