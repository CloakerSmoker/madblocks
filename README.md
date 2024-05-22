# madblocks

Like `badblocks`, but I wrote it instead (and it supports much larger disks).

## Features

* No 32 bit limits
* First class "resume" support
* Almost human-readable block numbers

## Unfeatures

* Written in a wacky toy language
* No read-only/non-destructive tests
* No filesystem integration

## Options

| Short Name | Long Name | Purpose |
| ---------- | --------- | ------- |
| `-b`       | `--block-size` | Set the size of a device block/sector to ensure alignment is maintained |
| `-s`       | `--size` | Set the size of the device (in total blocks) |
| `-p`       | `--batch-size` | Set the number of blocks to test at once (aka read/write this many blocks in one `write()` or `read()` call) |
| `-e`       | `--max-errors` | Set the maximum number of errors before giving up |
| `-r`       | `--resume` | Resume a pass at a given block |
| `-d`       | `--device` | Specify the device to be tested |
| `-o`       | `--output-file` | Specify a file to log errors to |

### Examples

```fish
sudo madblocks -b 512 -s 7814037168 -p 65535 -d /dev/sda -o sda-madblocks.txt
```

Test a 4tb drive (`/dev/sda`) with 512 byte sectors, 65535 sectors at a time. Write any errors to `sda-madblocks.txt` as well as stdout.

---

```fish
sudo madblocks -b 512 -s 7814037168 -p 65535 -d /dev/sda -o sda-madblocks.txt --resume 5 4,844,216,130
```

Same as previous, but resume pass 5 on block `4,844,216,130`.
