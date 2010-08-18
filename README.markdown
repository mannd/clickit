README
======

ClickIt's only task is to generate keystrokes to sign documents
automatically.  Many document signing systems require the user to use
a mouse to click a "Sign" button for each document.  This is an
extremely poor use of time when you have already reviewed the
documents and they just need to be electronically signed.  This is
particularly true for EMR (Electronic Medical Record) systems, which
in my experience are designed by individuals who have no concept of
what doctors actually do.  Apparently these systems don't include any
batch signing option for obscure medical-legal reasons.  ClickIt is a
real time-saver in this situation, allowing doctors to do more
important things (like taking care of patients) instead of mindlessly
clicking on a button.  ClickIt uses scripts written in the
[AutoIt scripting language](http://www.autoitscript.com/autoit3/index.shtml).
You can freely edit and redistribute these scripts using AutoIt.
However it is not necessary to install AutoIt to use ClickIt, you can
use the pre-compiled clickit.exe file to run ClickIt without using
AutoIt.

Installation
------------

Please read the file INSTALL.txt.  After installation and testing
return to these instructions.

How Does It Work?
-----------------

EMR systems have a shortcut key that can be used instead of a mouse
click to push the Sign button.  If the Sign button has an underlined
letter, then the shortcut key is the Alt key plus that letter.
Sometimes there is no easy way to find out the shortcut key.  Trial
and error (i.e. pressing the Alt along with every key on the keyboard
in sequence) will eventually hit on the right key.  For example, the
Sovera EMR uses Alt+c as the signing key.

Passwords
----------

Generally you have to provide your password before signing the first
document in a queue.  Do this first before starting ClickIt.

Do No Harm
----------

Be careful that you don't sign things that you should be reviewing
first.  Realize that even if everything looks like it can be signed
automatically when you start ClickIt, it is possible that an item that
is flagged will show up while ClickIt is running.  It is probably best
to run ClickIt at off-hours when this is unlikely to happen, or to
watch your screen when ClickIt is running.  We don't take
responsibility for errors in signing from ClickIt -- if you are
worried about that, don't run ClickIt!

Setting up Clickit
------------------

The combobox at the top of the ClickIt window must contain the exact
title line of the Window that has the documents you are trying to
sign.  Spelling and capitalization have to be exact to allow ClickIt
to find the right window.  If you have the AutoIt tools installed, you
can use the AutoIt Window Info tool to capture the window title and
paste it into the combo box.  You can type in a window title into the
combo box text box even if it is not already in the combo box list.
If you want to have this window title available for future sessions,
click the Add button after entering the text in the combobox.  Next
set the signature key, using a combination of the checkboxes and a
single letter entered into the Key text box.  Select how many repeats
(0 = infinity), what time in seconds between clicks, then click the
Run button to start.

Saving and Loading Scripts
--------------------------

You can save and load scripts to and from files.  File format is text
(INI files).  In addition you can load a script file at startup by
typing `clickit script.ini` on the comman line.  Use `clickit -q
script.ini` to run the script in quiet mode, i.e. no Gui visible.

Preloaded Scripts
-----------------

Sample scripts for Allscripts and Sovera EMR document signing are
included.  In addition the compiled files `clickitallscripts.exe` and
`clickitsovera.exe` run the respective scripts (`allscripts.ini` and
`sovera.ini`) automatically.

Compiling ClickIt
-----------------

If you have Gnu Make and the AutoIt tools installed, type `make` to
compile `clickit.exe` from `clickit.au3`.  `make zipfile` will compile
the program and make a zipfile package that includes the source code
and the compiled program(s).

Limitations
-----------

ClickIt doesn't know how to handle special keys -- such as F3, ESC,
Delete -- yet.
