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

