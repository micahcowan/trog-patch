.PHONY: all patch roms vimdiff zip clean reallyclean

PATCHES = trog-famicom2p.ips trog-fair-pvp.ips trog-nerfed.ips trog-mirrored-2p.ips

ROMS = $(patsubst %.ips,%.nes,$(PATCHES))

all: roms zip

patch: $(PATCHES)

# NOTE: requires original rom at trog.nes
roms: $(ROMS)

VERSION=v1.0
ZIPFILE=trog-nes-fair-pvp--IPS--$(VERSION).zip
ZIPDIR=trog-nes-fair-pvp-$(VERSION)
zip: $(ZIPFILE)

# normal clean leaves trog.lst
clean:
	rm -f $(ROMS) *.ips *.zip naked.lst patched.lst
	rm -fr $(ZIPDIR)

reallyclean: clean
	rm trog.lst

########


# generates "naked" listings of original vs modified, so I can confirm
# my modifications took place where expected.
vimdiff: naked.lst patched.lst

naked.lst: trog.nes trog.ini
	clever-disasm $^ | sed -e 's#/\*.*##' > $@

patched.lst: trog-fair.nes trog.ini
	clever-disasm $^ | sed -e 's#/\*.*##' > $@



## Building the patch .zip files ##

$(ZIPFILE): $(ZIPDIR)/README.txt $(patsubst %,$(ZIPDIR)/%,$(PATCHES))
	rm -f $@
	zip -r $@ $(ZIPDIR)

$(ZIPDIR)/README.txt: ZIP-INCLUDE-README.txt $(ZIPDIR)
#	cp $< $@
	sed 's/$$/'$$'\r/' < $< > $@	# Windows CRLF line endings

$(ZIPDIR)/%.ips: %.ips $(ZIPDIR)
	cp $< $@

$(ZIPDIR):
	mkdir -p $@


## ROM patching (requires original) ##

# trog-famicom2p.nes is just the original cart + famicom2p patch.
trog-famicom2p.nes: trog.nes trog-famicom2p.ips
	lipx.py -ab trog.nes trog-famicom2p.ips $@

# trog-fair-pvp.nes includes both the famicom2p patch, and the fair-pvp
# patch.
trog-fair-pvp.nes: trog-famicom2p.nes trog-fair-pvp.ips
	lipx.py -ab $^ $@

# trog-nerfed.nes includes all from trog-fair-pvp.nes,
#   plus "nerfing" (no tarpits, no eggs, no powerups, no enemies,
#   		    no falling, no invincibility)
trog-nerfed.nes: trog-fair-pvp.nes trog-nerfed.ips
	lipx.py -ab $^ $@

# trog-mirrored-2p.nes: trog-nerfed.nes + first player controls are
# 			mirrored to the second.
trog-mirrored-2p.nes: trog-nerfed.nes trog-mirrored-2p.ips
	lipx.py -ab $^ $@

# Produce a disassembly using clever-disasm, and my
# hand-crafted annotations
trog.lst: trog.nes trog.ini trog-preamble.txt
	sed -e 's/^/;; /' -e 's/$$/\r/' < trog-preamble.txt >| $@ || { rm $@; exit 1; }
	clever-disasm trog.nes trog.ini | sed -e 's/$$/\r/' >> $@ || { rm $@; exit 1; }

########

trog-%.ips: %-patch.asm
	nescom -o $@ -I $<
# The following lines are because nescom can produce
# output that makes it seem like it failed rather than
# succeeded. But also, nescom will happily finish running and exit with
# status zero even if errors were encountered, so... *sigh*
	@echo
	@echo "IPS patch successfully created (hopefully!)"

trog.nes:
	@echo "*** Cannot patch roms without original trog.nes file"
	@echo "    (But you can still generate IPS patches with \"make patch\")"
	@exit 1
