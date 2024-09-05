# Download AHN dataset
This will download a complete AHN dataset using a MakeFile.

> Note that AHN datasets are very large, consisting of multiple terabytes of LAZ files.

Copy the contents of this directory into [laz/dir].

Edit `get_ahn_via_md5.py` to refer to the correct AHN dataset URLs.

```(bash)
$ cd [laz/dir]
$ make all
```

