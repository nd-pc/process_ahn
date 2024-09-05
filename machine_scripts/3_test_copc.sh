#!/bin/bash
#3_test_copc.sh [-w N]
# params: w, positive integer, max age in days of data to test.

copcdir=<path/to/copc/dir/>
window=0

# Process flags.
while getopts w: flag; do
case "${flag}" in
    w) if [[ ${OPTARG} =~ ^[1-9][0-9]*$ ]]; then window=${OPTARG};  fi;; # Positive integers only.
esac
done; shift $(($OPTIND - 1));

# Process positional arguments.
scriptdir=$(dirname $0)

# This process requires the pdal environment to be active.
eval "$(conda shell.bash hook)"
conda activate pdal &> /dev/null

nohup ${scriptdir}/test_copc.sh -w${window} ${copcdir} ${scriptdir} >> ${scriptdir}/nohup_test_copc.out

