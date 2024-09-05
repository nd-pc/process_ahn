#!/bin/bash
#Copyright 2024 Netherlands eScience Center
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

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
