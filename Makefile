.PHONY: all format
.SUFFIXES: .lua .fnl
SRCFILE=compe-look

all: format lua/$(SRCFILE).lua

format: fnl/$(SRCFILE).fnl 
	fnlfmt --fix $<

lua/$(SRCFILE).lua: fnl/$(SRCFILE).fnl
	fennel --compile $< > $@
