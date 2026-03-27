# scanner

I'm writing scripts to scan various medical documents with a Fujitsu ScanSnap iX500 following [a blog from Neil Brown](https://neilzone.co.uk/2024/03/scanning-to-debian-12-with-a-fujitsi-ix500/) that inspired me to buy the same model.

## Dependencies

```
sudo apt install sane-utils imagemagick
```

- `sane-utils` provides `scanimage`
- `imagemagick` provides `magick` (only needed for `--pdf` mode)

## Finding your scanner's device string

Power on the scanner, connect it via USB, then run:

```
scanimage -L
```

This will print something like:

```
device `fujitsu:ScanSnap iX500:343632' is a FUJITSU ScanSnap iX500 flatbed scanner
```

The string `fujitsu:ScanSnap iX500:343632` is your device identifier. The trailing number (serial) will differ between units. Update the `-d` flag in `run.sh` if yours differs.

## Usage

```
./run.sh          # scan to PNG files in the current directory
./run.sh --pdf    # scan and merge into a single timestamped PDF
```

Output files are written to the directory you run the script from.

## Notes

- Scanning is duplex (double-sided) at 300 DPI
- In PNG mode, each page is a separate numbered file (e.g. `out1.png`, `out2.png`)
- The script exits immediately if `scanimage` is not found
