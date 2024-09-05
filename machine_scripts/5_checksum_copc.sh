#!/bin/bash
#5_checksum_copc.sh

copcdir=<path/to/copc/dir/>

# Process positional arguments.
scriptdir=$(dirname $0)

nohup ${scriptdir}/checksum_copc.sh ${copcdir} >> ${scriptdir}/nohup_checksum_copc.out

