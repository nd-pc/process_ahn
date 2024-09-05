# How to convert an AHN LAZ dataset to COPC with checksum
> Note that when running the "heavy" commands on a remote machine, prefix them by `nohup`, so the process continues when disconnected from the machine, and suffix them by '&', so the process doesn't block the terminal.
> When running the "PDAL" commands, the PDAL environment will have to be activated.
> Note that we have machine specific convenience scripts for running these processes in the `machine_scripts/` directory.

## Download AHN dataset (heavy)
Copy the contents of `download_ahn/.` into [laz/dir]

Edit `get_ahn_via_md5.py` to refer to the correct AHN dataset URLs.

```(bash)
$ cd [laz/dir]
$ make all
```

## Convert LAZ to COPC (heavy, PDAL)
> Note, PDAL must have been installed: `conda create -n pdal; conda activate pdal; conda install python-pdal`.

```(bash)
$ conda activate pdal
$ ./ahn_to_copc.sh -p2 -m3 [laz/dir] [copc/dir]
```

> The `p` argument determines the number of concurrent processes.
> The `m` argument determines the hierarchy of AHN LAZ files to merge into one COPC file. For example, for `m3`, all LAZ files for which the name starts with the same `C_xxx` will be merged into one COPC.

## Count COPC files created
```(bash)
$ ./count_copc.sh [copc/dir]
```

## Test COPC files (heavy, PDAL)
```(bash)
$ conda activate pdal
$ ./test_copc.sh [copc/dir] 
```

> This process can optionally be instructed to only check files created recently, within a fixed number of days:
```(bash)
$ conda activate pdal
$ ./test_copc.sh -w[days] [copc/dir]
```

## List invalid COPC files
> Note that any invalid COPC file can be deleted, after which the conversion process can be repeated. The conversion process will not process any data for which the output COPC files already exist.

```(bash)
$ ./list_copc_failures.sh [test_file] [copc/dir]
```

## Create checksum (heavy)
> Note that the main purpose of creating a checksum of the COPC directory is to facilitate safe transfer of the data.

```(bash)
$ ./checksum_copc.sh [copc/dir]
```

