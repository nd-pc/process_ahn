#!/bin/bash

# Process positional arguments.
testfile=$1
copcdir=$2

if ! [ -f ${testfile} ]; then
    echo "Error: test file does not exist."
fi
if ! [ -d ${copcdir} ]; then
    echo "Error: COPC directory does not exist."
fi

echo "Comparing test file ${testfile}"
echo "to files in dir ${copcdir}"

# Check the test file for occurrences of a correct pdal info call for a file and compare that to the copc directory.
# Output all the files in the copc directory that did not occur.
copc_correct=$(cat ${testfile} | grep -E '"filename": "'${copcdir}'.*\.copc\.laz' -o | grep -E '....\.copc\.laz' -o | sort -u)
copc_all=$(ls -1a ${copcdir} | grep copc.laz)

diff <(echo "${copc_correct}") <(echo "${copc_all}")

echo "======================"

