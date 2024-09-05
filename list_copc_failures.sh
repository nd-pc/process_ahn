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

