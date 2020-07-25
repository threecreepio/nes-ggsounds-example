AS = ca65
CC = cc65
LD = ld65

.PHONY: clean
build: src/music/songs.asm main.nes

%.o: %.asm
	$(AS) --create-dep "$@.dep" -g --debug-info $< -o $@

%.asm: %.txt
	python lib/ft_txt_to_asm.py "$<"

main.nes: src/main.o
	$(LD)  --dbgfile "$@.dbg" -C layout $^ -o $@

clean:
	rm -f main.nes main.nes.dbg **/*.o **/*.o.dep

include $(wildcard *.dep **/*.dep)
