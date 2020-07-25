# GGSound NES Example

Minimal example of using GGSound with cc65.

## Description

If you open src/main.asm you can see the code needed to initialize and use ggsound.

In the src/music folder there is a "songs.ftm" file which contains music that can be opened with FamiTracker. Edit the music in there, and create a new "songs.txt" file by going into File > Export text.

The build will then create assembly files for that text file.

## Building

Make sure you have cc65 installed, and then run `make` in this folder.

If successful there should be a main.nes file that you can run on an NES or emulator.


Enjoy!
/threecreepio
