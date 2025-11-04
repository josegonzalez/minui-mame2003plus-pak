# minui-mame2003plus-pak

A MinUI Emu Pak for MAME 2003 Plus, wrapping the [retroarch core from christianhaitian](https://github.com/christianhaitian/retroarch-cores/blob/master/aarch64/mame2003_plus_libretro.so.zip).

## Requirements

This pak is designed and tested on the following MinUI Platforms and devices:

- `tg5040`: Trimui Brick (formerly `tg3040`) and Trimui Smart Pro

Use the correct platform for your device.

## Installation

1. Mount your MinUI SD card.
2. Download the latest release from Github. It will be named `MAME2003PLUS.pak.zip`.
3. Copy the zip file to `/Emus/$PLATFORM/MAME2003PLUS.pak.zip`.
4. Extract the zip in place, then delete the zip file.
5. Confirm that there is a `/Emus/$PLATFORM/MAME2003PLUS.pak/launch.sh` file on your SD card.
6. Create a folder at `/Roms/Arcade (MAME2003PLUS)` and place your roms in this directory.
7. Unmount your SD Card and insert it into your MinUI device.

## Credits

- @christianhaitian for prebuilding cores
