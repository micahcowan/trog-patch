.PHONY: all patch

all: trog.lst

patch: trog-patched.nes

#trog-patched.nes: trog-p1.nes trog-fair-pvp.ips
trog-patched.nes: trog-p1.nes trog-nerfed.ips
	lipx.py -ab $^ $@

trog-p1.nes: trog.nes trog-famicom2p.ips
	lipx.py -ab trog.nes trog-famicom2p.ips $@

trog.lst: trog.nes trog.ini
	clever-disasm trog.nes trog.ini > $@ || { rm $@; exit 1; }

trog-patched.lst: trog-patched.nes trog.ini
	clever-disasm trog-patched.nes trog.ini > $@ || { rm $@; exit 1; }

trog-%.ips: %-patch.asm
	nescom -o $@ -I $<
# The following lines are because nescom can produce
# output that makes it seem like it failed rather than
# succeeded.
	@echo
	@echo IPS patch successfully created

trog.nes:
	@echo "*** Cannot proceed without trog.nes"
	@exit 1
