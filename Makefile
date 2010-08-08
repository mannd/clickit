# Makefile for ClickIt
# Copyright (c) 2010 EP Studios, Inc.
# License: GPL V3

VERSION = 1.0.0
AUT2EXE = "C:/Program Files/AutoIt3/Aut2Exe/Aut2exe.exe"
ZIP := zip
ICON := signature.ico
WAV := beep-10.wav beep-7.wav

project := clickit
allscripts := allscripts
sovera := sovera

program := $(project).exe
allscripts_program := $(project)$(allscripts).exe
sovera_program := $(project)$(sovera).exe
allscripts_ini := $(allscripts).ini
sovera_ini := $(sovera).ini

examples := $(allscripts_program) $(sovera_program)
programs := $(program) $(examples)

zipfile := $(project)-$(VERSION).zip

.PHONY : all
all : $(programs)

$(allscripts_program) : $(program) $(allscripts_ini)

$(sovera_program) : $(program) $(sovera_ini)

%.exe : %.au3 $(ICON) $(WAV)
	$(AUT2EXE) //in $< //out $@ //icon $(ICON)

.PHONY : package
package : $(zipfile)

$(zipfile): *
	$(ZIP) -r clickit-$(VERSION).zip *
