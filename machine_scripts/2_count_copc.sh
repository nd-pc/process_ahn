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

#2_count_copc.sh


lazdir=<path/to/laz/dir/>
copcdir=<path/to/copc/dir/>

current=$(ls ${copcdir} | grep copc.laz | wc -w)
target=$(ls -Sr ${lazdir}C_* | grep -E "(las|laz|LAS|LAZ)$" | sed 's|.*/C_||' | cut -c1-3 | awk '!seen[$0]++' | wc -w)

echo "AHN COPC files in ${copcdir}: ${current} / ${target}"

