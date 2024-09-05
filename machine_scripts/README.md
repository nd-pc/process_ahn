# Convenience scripts for running the process on a specific machine.
This directory contains convenience scripts that will set the required directories and run the processes on a specific dataset. Each process has its own script.

Before starting the process on a new machine, the five scripts should be copied to their own directory on that machine. That directory should also contain symbolic links to the following scripts:

```(bash)
ln -s ../ahn_to_copc.sh
ln -s ../checksum_copc.sh
ln -s ../count_copc.sh
ln -s ../las_to_copc.py
ln -s ../list_copc_failures.sh
ln -s ../test_copc.sh
```

The start of each script defines some directories relevant to the process. These should be edited to fit the specific machine and dataset to process.

The scripts can then be called in order. Each of these scripts will start the relevant process using nohup, so it will continue after closing the connection to the machine.

> Note that usually the scripts should be suffixed by `&` so they don't block the terminal. If you forgot this, you can temporarily pause the script (`Ctrl-Z`) and continue it in the background with `bg`.

