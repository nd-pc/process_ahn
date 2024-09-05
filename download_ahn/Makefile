.PHONY : all

url_file:
	 python3 get_ahn_via_md5.py

download:
	# -P 4 indicates to run 4 processes at the same time
	cat ahn_files.txt | sort | uniq | xargs -n 1 -P 4 wget -c -nv

check:
	md5sum -c ahn.md5sum

all: url_file download check
