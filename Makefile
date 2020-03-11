.PHONY: all patch

all: trog.lst

patch: trog-patched.nes

trog-patched.nes: trog.nes trog-patched.ips
	lipx.py -ab trog.nes trog-patched.ips $@

trog.lst: trog.nes trog.ini
	clever-disasm trog.nes trog.ini > $@ || { rm $@; exit 1; }

trog-patched.ips: patch.asm
	nescom -o $@ -I patch.asm
# The following lines are because nescom can produce
# output that makes it seem like it failed rather than
# succeeded.
	@echo
	@echo IPS patch successfully created

trog.nes:
	@echo "*** Cannot proceed without trog.nes"
	@exit 1
