# trog-patch
An exploration of disassembled code from *Trog!* on the NES

Current results:
  * Created the following Game Genie code hacks:
    * **ZEUAIAPA** - Infinite t-rex (1 of 2 - starts players as t-rex)
    * **SUXPZKVS** - Infinite t-rex (2 of 2 - disables t-rex timeout)
    * **SUSPZKVS** - Infinite invincibility
    * **VNVELESO** - Infinite fireballs (1 of 2 - enable fireball at start)
    * **SUSOZKVS** - Infinite fireballs (2 of 2 - disable fireball timeout)
    * **ATVPTTXZ** - Removes all enemies (trogs) from the game. Kinda eerie!
    * **TEOLPPLA** - Players at maximum speed
    * **EYSAUTEI** - Players only fall if they *are* invincible
    * **AEKEZAGP** - Players don't spawn with invincibility
    * **AAXOAXPZ** - Prevents players from picking up powerup items
    * **GAOOGXTE** - Prevents players from picking up *eggs*
    * **PXOKUSPE** - Prevents powerups and tarpits - and *exits*! - from spawning
    * **EOOTSAAP** - Enables player 2 to join/continue with the A button (useful via Everdrive on the Famicom, which lacks the start button).
  * **Blaze It!** hard mode: trogs are faster than ever, players at their max speed
  * **Famicom 2-player patch**: An IPS patch version of the Famicom 2p game genie code mentioned above. This hack was the original motivation for me to dig into hacking this game!
  * **Fair PvP patch**: Made player-vs-player violence more fair and balanced (on the original cartridge (but not the original arcade game), player 1 beats player 2 easily in any face-to-face battle). This was the secondary motivation for digging into *Trog!* hacking.
  * A patch that removes all spawned map items (tarpits, eggs, speed weeds, slow shrooms, horseshoes and pineapples), and prevents falling off the edges (this patch was created for easier testing of the Fair PvP Patch).
  * A patch that mirrors player one's controls to player two (created to test the Fair PvP Patch project with just one controller)

Future planned hacks:
  * Permanent fireballs
  * Trogs at their final speed, throughout the game? And maximum # of trogs
  * First egg triggers warp

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
  1. Have [Bisqwit](http://bisqwit.iki.fi/)'s [nescom / clever-disasm](https://github.com/bisqwit/nescom) installed and on your `PATH`.
  1. Have a copy of the .nes ROM file for the US version of the Trog game in the same directory as the `Makefile`, named `trog.nes`.
  1. Run `make`.

In order to patch your .nes ROM, in addition to the prerequisites above you must also:
  1. Have [lipx.py](https://github.com/kylon/Lipx) installed on your `PATH`. (The first suitable command-line IPS patcher I could find on GitHub.)
  1. Run `make patch`.

**Alternatively**, you can use your favorite of any number of other available IPS patchers available on the internet.

**Note**, at the time of this writing, the IPS patch files actually can't be generated from the `.asm` listings using Bisqwit's unmodified version of **nescom**. The reason is that **nescom** insists on including some bits in the patch that don't belong in a patch against NES roms, and have the effect of corrupting the results. I used a modification of the original tools in order to generate my IPS files; I will update this README when I have published these modifications (and likely some others) and can provide a link.

The generated `trog.lst` file, using annotations I've placed in the `trog.ini` file, includes mnemonic variable and function/location names and some comments, that aid in reading ,and especially searching for things in, the disassembled code. It is not my intention to completely map out, annotate, or name things in this code; I'm just trying to find my way around well enough to find the right spots to modify in order to effect the desired changes.

Note that the produced disassembly file is *not* suitable for re-assembling into a functioning ROM - it is for human reading purposes only. Various of the inline annotations interfere with reassembly, and in any case, I'm given to understand that the disassembler won't always generate code that would preserve the original bytes when reassembled (the known culprit being the case when a 16-bit memory address is used for a zero-page access, when the operation supports the 8-bit memory access format).

Also there are some non-printable bytes in the first couple lines of `trog.ini`. This is because I keep a couple of vim macros at the top of that file, that I use to ease some operations when working with the listing file. Sorry for that, maybe at some point I'll figure out how to store and load it without representing them in raw form.
