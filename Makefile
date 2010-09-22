# Makefile for ClickIt
# Copyright (c) 2010 EP Studios, Inc.
# License: GPL V3

VERSION = 1.0.2
AUT2EXE = "C:/Program Files/AutoIt3/Aut2Exe/Aut2exe.exe"
ZIP := zip
ICON := signature.ico
WAV := beep-10.wav beep-7.wav
RM := rm -f

project := clickit
allscripts := allscripts
sovera := sovera

lastsettings := _last.ini
windowlist := windowlist

program := $(project).exe
allscripts_program := $(project)$(allscripts).exe
sovera_program := $(project)$(sovera).exe
allscripts_ini := $(allscripts).ini
sovera_ini := $(sovera).ini
settings := $(sovera_ini) $(allscripts.ini)

examples := $(allscripts_program) $(sovera_program)
programs := $(program) $(examples)

zipfile := $(project)-$(VERSION).zip

.PHONY : all
all : $(programs)

$(allscripts_program) : $(program) $(allscripts_ini)

$(sovera_program) : $(program) $(sovera_ini)

%.exe : %.au3 $(ICON) $(WAV)
	$(AUT2EXE) //in $< //out $@ //icon $(ICON)

# make package will give missing file error if no example ini files
# you must save those example scripts from clickit
.PHONY : distclean package
package : clean $(examples) all $(zipfile)

$(zipfile):
	$(ZIP) -r clickit-$(VERSION).zip *

.PHONY : clean distclean
clean :
	$(RM) *.zip
	$(RM) $(lastsettings)
	$(RM) $(windowlist)

distclean : clean
	$(RM) $(programs)
	$(RM) $(settings)
	$(RM) $(examples)

