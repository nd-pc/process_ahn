import requests
from pathlib import Path

# File checksums (md5) are available for 
# - [AHN1](https://gist.github.com/fwrite/2ba51be6835407125752897fd4641ded#file-ahn1-md5)
# - [AHN2](https://gist.github.com/fwrite/2ba51be6835407125752897fd4641ded#file-ahn2-md5)
# - [AHN3](https://geoforum.nl/t/checksum-for-the-ahn-laz-downloads/4002/2)
# - [AHN3](https://gist.githubusercontent.com/arbakker/dcca00384cddbdf10c0421ed26d8911c/raw/f43465d287a654254e21851cce38324eba75d03c/checksum_laz.md5)
# - [AHN4](https://gist.github.com/fwrite/6bb4ad23335c861f9f3162484e57a112)
# - [AHN4](https://gist.githubusercontent.com/fwrite/6bb4ad23335c861f9f3162484e57a112/raw/ee5274c7c6cf42144d569e303cf93bcede3e2da1/AHN4.md5)

url = "https://gist.githubusercontent.com/fwrite/6bb4ad23335c861f9f3162484e57a112/raw/ee5274c7c6cf42144d569e303cf93bcede3e2da1/AHN4.md5"
md5sums = requests.get(url, stream=False).text

with open('ahn.md5sum', 'w') as fh:
    fh.write(md5sums)

dataset = "AHN4"
with open('ahn_files.txt', 'w') as fh:
    for line in md5sums.split("\n"):
        splitted = line.split("  ")
        if len(splitted) > 1:
            stem = Path(splitted[1]).stem
            print(f"https://geotiles.citg.tudelft.nl/{dataset}/{stem}.LAZ", file=fh)
