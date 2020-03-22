# trog-patch
An exploration of disassembled code from *Trog!* on the NES

Current results:
  * Created the following Game Genie code hacks:
    * **ATVPTTXZ** - Removes all enemies (trogs) from the game. Kinda eerie!
    * **AAXOAXPZ** - Prevents players from picking up powerup items
    * **GAOOGXTE** - Prevents players from picking up *eggs*
    * **PXOKUSPE** - Prevents powerups and tarpits - and *exits*! - from spawning
    * **EYSAUTEI** - Players only fall if they *are* invincible
    * **AEKEZAGP** - Players don't spawn with invincibility
    * **EOOTSAAP** - Enables player 2 to join/continue with the A button (useful via Everdrive on the Famicom, which lacks the start button). Also created an IPS patch for this, `trog-famicom2p.ips`. This hack was the original motivation for me to dig into hacking this game!

Future planned hacks:
  * Make player-vs-player violence more fair and balanced (or at least random - on the original cartridge, player 1 beats player 2 in any face-to-face battle). This was the secondary motivation for digging into *Trog!* hacking.
  * Remove all tarpits from the game (except the warps)
  * Prevent falling off edges
  * Remove all power-ups from the game
  * Player 2 mirrors player 1 movements and actions

(Most of the planned hacks above are in the service of making testing of player-vs-player punch-outs much easier.)

This repository *does not include* either the NES ROM file for the game, nor the decompiled source listings, as both of these items are protected under copyright law. You must provide the ROM yourself, and it must match the following:

```
Database match: Trog! (USA)
Database: No-Intro: Nintendo Entertainment System (v. 20180803-121122)
File SHA-1: DA36075188C98C0434BC78CE0554942948F4228E
File CRC32: DD6141DF
ROM SHA-1: 29CA7CC398B855472C9D94E7581BE8288468382B
ROM CRC32: EE6892EB
```

If a suitable `trog.nes` file is supplied in the working directory, it can
  * generate disassembled program code for the game, with variable and subroutine names, and comments, taken from the `trog.ini` file, and
  * patch that file (constructing the patched version at `trog-patched.nes`) so as to allow 2-player enjoyment on a Famicom device or emulation.

In order to use it to generate disassembled code, you must:
  1. Have [Bisqwit](http://bisqwit.iki.fi/)'s [clever-disasm](https://github.com/bisqwit/nescom) installed and on your `PATH`.
  1. Have a copy of the .nes ROM file for the US version of the Trog game in the same directory as the `Makefile`, named `trog.nes`.
  1. Run `make`.

In order to patch your .nes ROM, in addition to the prerequisites above you must also:
  1. Have [lipx.py](https://github.com/kylon/Lipx) installed on your `PATH`. (The first suitable command-line IPS patcher I could find on GitHub.)
  1. Run `make patch`.

**Alternatively**, you can use your favorite of any number of other available IPS patchers available on the internet.

The generated `trog.lst` file, using annotations I've placed in the `trog.ini` file, includes mnemonic variable and function/location names and some comments, that aid in reading ,and especially searching for things in, the disassembled code. It is not my intention to completely map out, annotate, or name things in this code; I'm just trying to find my way around well enough to find the right spots to modify in order to effect the desired changes.

Note that the produced disassembly file is *not* suitable for re-assembling into a functioning ROM - it is for human reading purposes only. Various of the inline annotations interfere with reassembly, and in any case, I'm given to understand that the disassembler won't always generate code that would preserve the original bytes when reassembled (the known culprit being the case when a 16-bit memory address is used for a zero-page access, when the operation supports the 8-bit memory access format).

Also there are some non-printable bytes in the first couple lines of `trog.ini`. This is because I keep a couple of vim macros at the top of that file, that I use to ease some operations when working with the listing file. Sorry for that, maybe at some point I'll figure out how to store and load it without representing them in raw form.
