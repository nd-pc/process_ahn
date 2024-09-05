#!/bin/bash
window=0

# Process flags.
while getopts w: flag; do
case "${flag}" in
    w) if [[ ${OPTARG} =~ ^[1-9][0-9]*$ ]]; then window=${OPTARG}; fi;; # Positive integers only.
esac
done; shift $(($OPTIND - 1));

# Process positional arguments.
copcdir=$1
outdir=$2

if ! [ -d ${copcdir} ]; then
    echo "Error: COPC directory does not exist."
fi
if [ ${outdir} == "" ]; then
    outdir="."
fi


if [ 0 -ge ${window} ] && [ -f ${outdir}/test_copc.md ]; then
    rm ${outdir}/test_copc.md
fi

echo "Writing test output to ${outdir}/test_copc.md"

# Export variables to be used in xargs string.
export copcdir
export outdir

# Process the copc.las files in the COPC directory:
# test whether their first point can be loaded.
if [ 0 -lt ${window} ]; then
	find ${copcdir}/* -maxdepth 1 -mtime -${window} | grep -E "(.copc.laz)$" | xargs -P24 -I{} sh -c 'echo "$(date): processing {}..."; pdal info --metadata -p 0 {} | tr -s "\n\r\t" " " | cut -c1-2048 >> ${outdir}/test_copc.md; echo " {} done"'
else
    ls ${copcdir}/* | grep -E "(.copc.laz)$" | xargs -P24 -I{} sh -c 'echo "$(date): processing {}..."; pdal info --metadata -p 0 {} | tr -s "\n\r\t" " " | cut -c1-2048 >> ${outdir}/test_copc.md; echo " {} done"'
fi
