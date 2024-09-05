#!/bin/bash
#2_count_copc.sh

lazdir=<path/to/laz/dir/>
copcdir=<path/to/copc/dir/>

current=$(ls ${copcdir} | grep copc.laz | wc -w)
target=$(ls -Sr ${lazdir}C_* | grep -E "(las|laz|LAS|LAZ)$" | sed 's|.*/C_||' | cut -c1-3 | awk '!seen[$0]++' | wc -w)

echo "AHN COPC files in ${copcdir}: ${current} / ${target}"

