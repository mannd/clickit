ClickIt README
==============

ClickIt's only task is to generate keystrokes to sign documents automatically.  Many document signing systems require the user to use a mouse to click a "Sign" button for each document.  This is an extremely poor use of time when you have already reviewed the documents and they just need to be electronically signed.  This is particularly true for  EMR (Electronic Medical Record) systems, which in my experience are designed by individuals who have no concept of what doctors actually do.  Apparently these systems don't include any batch signing option for obscure medical-legal reasons.  ClickIt is a real time-saver in this situation, allowing doctors to do more important things (like taking care of patients) instead of mindlessly clicking on a button.  ClickIt uses scripts written in the [AutoIt scripting language](http://www.autoitscript.com/autoit3/index.shtml).  You can freely edit and redistribute these scripts using AutoIt.  However it is not necessary to install AutoIt to use ClickIt, you can use the pre-compiled clickit.exe file to run ClickIt without using AutoIt.

Installation
------------

Please read the file INSTALL.txt.  After installation and testing return to these instructions.

How Does It Work?
-------------------

EMR systems have a shortcut key that can be used instead of a mouse click to push the Sign button.  If the Sign button has an underlined letter, then the shortcut key is the Alt key plus that letter.  Sometimes there is no easy way to find out the shortcut key.  Trial and error (i.e. pressing the Alt along with every key on the keyboard in sequence) will eventually hit on the right key.  For example, the Sovera EMR uses Alt+c as the signing key.

Passwords
----------

Generally you have to provide your password before signing the first document in a queue.  Do this first before starting ClickIt.

Harm Done
---------

Be careful that you don't sign things that you should be reviewing first.  Realize that even if everything looks like it can be signed automatically when you start ClickIt, it is possible that an item that is flagged will show up while ClickIt is running.  It is probably best to run ClickIt at off-hours when this is unlikely to happen, or to watch your screen when ClickIt is running.  We don't take responsibility for errors in signing from ClickIt -- if you are worried about that, don't run ClickIt!

Setting up Clickit
--------------------

The combobox at the top of the ClickIt window must contain the exact title line of the Window that has the documents you are trying to sign.  Spelling and capitalization have to be exact to allow ClickIt to find the right window.  If the window title is not a part of the combobox list you can just type it in.  If you want to have this window title available for future sessions, click the Add button after entering the text in the combobox.  Next set the signature key, using a combination of the checkboxes and the ...........

Using with Allscripts
---------------------

Go to your documents page.  IMPORTANT: Sign the first one yourself, manually, as you have to enter your password the first time.  After that, leaving the Allscripts browser window open, double click on clickit.bat on your desktop, and then go away and have a cup of coffee.  The program will sign about 20 documents, then stop.  If there are more to sign, just double click clickit.bat again.  If all are signed and the clickit.bat window (an old-fashioned back dos window) is still open right-click on the Scriptit task in the taskbar and select Terminate.  IMPORTANT: Always end the program before going to any other Allscripts page, as the program will continue to generate keystrokes, possibly doing things you don't want in Allscripts.

Using with Sovera
-----------------

Bring up you're documents that need to be signed.  Sign the first one.  This will bring up the password dialog.  Fill in the password, then double click on clickitsovera on your desktop.  Now sit back and relax or do something more useful than clicking on a computer screen.  The signing is all automatic!

Stopping ClickIt
----------------

If there are too many signatures so that ClickIt stops before you are done signing, just restart it.  If the signatures end before ClickIt does, you will hear some annoying beeps.  To stop ClickIt, just right-click on the Windows taskbar where is says "Scriptit" and close/terminate.

