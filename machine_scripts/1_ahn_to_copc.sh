#!/bin/bash
#1_ahn_to_copc.sh [-p N]
# params: p, positive integer, number of processes.
#         large datasets may require fewer processes to prevent caching.

lazdir=<path/to/laz/dir/>
copcdir=<path/ro/copc/dir/>
processes=1
merge=3

# Process flags.
while getopts p: flag; do
case "${flag}" in
    p) if [[ ${OPTARG} =~ ^[1-9][0-9]*$ ]]; then processes=${OPTARG};  fi;; # Positive integers only.
esac
done; shift $(($OPTIND - 1));

# Process positional arguments.
scriptdir=$(dirname $0)

# This process requires the pdal environment to be active.
eval "$(conda shell.bash hook)"
conda activate pdal &> /dev/null

nohup ${scriptdir}/ahn_to_copc.sh -p${processes} -m${merge} ${lazdir} ${copcdir} >> ${scriptdir}/nohup_ahn_to_copc.out

