#!/bin/bash
merge=3
proc=4

# Process flags.
while getopts m:p: flag; do
case "${flag}" in
    m) if [[ ${OPTARG} =~ ^[1-9][0-9]*$ ]]; then merge=${OPTARG}; fi;; # Positive integers only.
    p) if [[ ${OPTARG} =~ ^[1-9][0-9]*$ ]]; then proc=${OPTARG};  fi;; # Positive integers only.
esac
done; shift $(($OPTIND - 1));

# Process positional arguments.
scriptdir=$(dirname $0)
lazdir=$1
copcdir=$2

if ! [ -d ${lazdir} ]; then
    echo "Error: LAZ directory does not exist."
fi
if ! [ -d ${copcdir} ]; then
    mkdir -p ${copcdir}
fi

# Export variables to be used in xargs string.
export scriptdir
export lazdir
export copcdir

# Process the LAZ files in the input directory,
# ordered from small to large:
# extract the filename after the "C_" part,
# extract the first m characters,
# ignore lines that were already seen
# (note that the lines are not sorted, like 'sort -u'),
# start a thread per item to process:
#     if the output does not exist then
#         convert the input LAZ files to one output COPC file.
ls -Sr ${lazdir}/C_* | grep -E "(las|laz|LAS|LAZ)$" | sed 's|.*/C_||' | cut -c1-${merge} | awk '!seen[$0]++' | xargs -P${proc} -I{} sh -c 'if ! [ -f ${copcdir}/C{}.copc.laz ]; then echo "$(date): processing {}..."; python ${scriptdir}/las_to_copc.py ${lazdir}/C_{}* -o ${copcdir}/C{} >> ${copcdir}/log.txt; echo "$(date): {} done"; fi'

