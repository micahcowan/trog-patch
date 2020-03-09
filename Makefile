all: trog.lst

trog.lst: trog.nes trog.ini
	clever-disasm trog.nes trog.ini > $@ || { rm $@; exit 1; }
