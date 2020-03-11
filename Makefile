all: trog.lst

trog.lst: trog.nes trog.ini
	clever-disasm trog.nes trog.ini > $@ || { rm $@; exit 1; }

trog-patched.ips:
	nescom -o $@ -I patch.asm
# The following lines are because nescom can produce
# output that makes it seem like it failed rather than
# succeeded.
	@echo
	@echo IPS patch successfully created
