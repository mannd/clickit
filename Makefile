# Makefile for ClickIt
# Copyright (c) 2010 EP Studios, Inc.
# License: GPL V3

AUT2EXE = "C:/Program Files/AutoIt3/Aut2Exe/Aut2exe.exe"
PROJ = clickit
ICON = signature.ico

$(PROJ).exe : $(PROJ).au3 $(ICON)
	$(AUT2EXE) //in $< //out $@ //icon $(ICON)

