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


import argparse
from pathlib import Path
import pdal
import sys

parser = argparse.ArgumentParser(description="Convert one or more las/laz files into a COPC file.")
parser.add_argument("input", help="Input las/laz path(s). Wildcard patterns are allowed.", nargs="+", type=Path)
parser.add_argument("--out", "-o", help="Output COPC file (default: %(default)s.copc.laz). The '.copc.laz' suffix will be added if missing.", type=Path, default="./output")
parser.add_argument("--srs", help="Spatial Reference System of the input las files.")
parser.add_argument("--overwrite", help="Whether to overwrite an existing output file.")

args = parser.parse_args()

las_paths = []
for path in args.input:
    for path in path.resolve().parent.glob(path.name):
        if path.is_file():
            las_paths.append(path)
if not las_paths:
    print("No input.")
    sys.exit()

copc_out = args.out.resolve()
if copc_out.is_dir() and len(las_paths) == 1:
    copc_out = copc_out.joinpath(las_paths[0])
while copc_out.suffix != '':
    copc_out = copc_out.stem
copc_out = copc_out.with_suffix(".copc.laz")
if not args.overwrite and copc_out.exists():
    print(f"output {copc_out} already exists.")
    print("use --overwrite to enable overwriting this file.")
    sys.exit()

print("Converting files:")
for path in las_paths:
    print(f"  {path}")
print("into COPC:")
print(f"  {copc_out}")


readers_list = []
if args.srs:
    readers_list = [pdal.Reader.las(filename=str(path), default_srs=args.srs) for path in las_paths]
else:
    readers_list = [pdal.Reader.las(filename=str(path)) for path in las_paths]
writer = pdal.Writer.copc(filename=str(copc_out), forward="all")

# Note, explicit merge stage mandatory.
pipeline = pdal.Pipeline(readers_list) | pdal.Filter.merge() | writer

count = pipeline.execute()

metadata = pipeline.metadata
log = pipeline.log

print(count)
print(log)
