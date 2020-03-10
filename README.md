# trog-patch
An exploration of disassembled code from Trog on NES

This project represents my attempt at exploring the 6502 assembly code for the game Trog on the NES, with a view to modifying it so as not to require a 2P start button (so that the US game ROM may be played via Everdrive and the like on Japanese Famicom systems, which lack 2P start and select). A secondary goal is to make player-versus-player combat more "fair", as, unlike with the original arcade game, being one player versus the other does make a significant difference in terms of who is likely to win (I believe P1 is the favored player - I don't know details, just remember a friend and I playing and him consistently beating me in fist fights, then we swapped controllers and I started beating him consistently!)

This repository *does not include* either the NES ROM file for the game, nor the decompiled source listings, as both of these items are protected under copyright law. Instead, it contains just a `trog.ini` file and a simple `Makefile` to use it together with a ROM file, and generate a `trog.lst` file containing an annotated 6502 disassembly of the ROM.

In order to use it, you must:
  1. Have [Bisqwit](http://bisqwit.iki.fi/)'s [clever-disasm](https://github.com/bisqwit/nescom) installed and on your `PATH`.
  1. Have a copy of the .nes ROM file for the US version of the Trog game in the same directory as the `Makefile`, named `trog.nes`.
  1. Run `make`.

The `trog.lst` file, using annotations I've placed in the `trog.ini` file, then includes mnemonic variable and function/location names and some comments, that aid in reading ,and especially searching for things in, the disassembled code. It is not my intention to completely map out, annotate, or name things in this code; I'm just trying to find my way around well enough to find the right spots to modify in order to effect the desired changes.

Note that the produced disassembly file is *not* suitable for re-assembling into a functioning ROM - it is for human reading purposes only. Various of the inline annotations interfere with reassembly, and in any case, I'm given to understand that the disassembler won't always generate code that would preserve the original bytes when reassembled (the known culprit being the case when a 16-bit memory address is used for a zero-page access, when the operation supports the 8-bit memory access format).

Also there are some non-printable bytes in the first couple lines of `trog.ini`. This is because I keep a couple of vim macros at the top of that file, that I use to ease some operations when working with the listing file. Sorry for that, maybe at some point I'll figure out how to store and load it without representing them in raw form.
