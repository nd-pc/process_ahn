#!/bin/bash
#4_list_copc_failures.sh

copcdir=<path/to/copc/dir/>

# Process positional arguments.
scriptdir=$(dirname $0)
testfile=${scriptdir}/test_copc.md

${scriptdir}/list_copc_failures.sh ${testfile} ${copcdir}

