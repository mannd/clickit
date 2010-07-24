Clickit README

Clickit's only task is to generate Alt-S keystrokes to automatically sign documents.  It uses the free Microsoft tool scriptit.exe and a configuration file.  If you want to do something else with it, the documentation for scriptit is included with this download.  Now it can be used to sign both Allscripts documents and documents on the EMR system Sovera.  A more generalized version of Clickit is coming Real Soon Now.

Installation

Download the zip file and unzip it anywhere you want.  Open the Clickit folder that you unzipped.  Copy the scriptit.exe and notepadtest.ini files to the root directory of the C: drive (C:\).  Open either the Clickit-Vista or Clickit-XP folder (depending on whether you have Vista or Windows XP) and copy the allscripts.ini file to C:\.  If you are using Sovera, drag the sovera.ini file to C:\ too.  Drag the 3 bat files to the desktop.  If you put the files anywhere else you will need to modify the bat files with the correct paths to make them work.

Test First

Open Notepad to a new document.  The title bar of notepad should be Untitled - Notepad.  Double click on clickittest.bat on your desktop.  Some text should magically appear in the notepad window.  If it does, it is working!

Using with Allscripts

Go to your documents page.  IMPORTANT: Sign the first one yourself, manually, as you have to enter your password the first time.  After that, leaving the Allscripts browser window open, double click on clickit.bat on your desktop, and then go away and have a cup of coffee.  The program will sign about 20 documents, then stop.  If there are more to sign, just double click clickit.bat again.  If all are signed and the clickit.bat window (an old-fashioned back dos window) is still open, press Control-Break (the break key is usually above the number pad) to end the program, or right-click on the Scriptit window or task on the taskbar and select Terminate.  IMPORTANT: Always end the program before going to any other Allscripts page, as the program will continue to generate keystrokes, possibly doing things you don't want in Allscripts.

Using with Sovera

Bring up you're documents that need to be signed.  Sign the first one.  This will bring up the password dialog.  Fill in the password, then double click on clickitsovera on your desktop.  Now sit back and relax or do something more useful than clicking on a computer screen.  The signing is all automatic!

Stopping Clickit

If there are too many signatures so that clickit stops before you are done signing, just restart it.  If the signatures end before clickit does, you will hear some annoying beeps.  To stop clickit, just right-click on the Windows taskbar where is says "Scriptit" and close/terminate.

Multiple Clickits

Yes you can open multiple clickit windows at the same time.  This will potentially sign the documents faster, but you might hear some funny clunking sounds if the web browser can't keep up with clickit.  But, no harm done.

Harm Done

Be careful that you don't sign things that you should be reviewing first, and realize that even if everything looks like it can be signed automatically when you start clickit, it is possible that an item that is flagged will show up while clickit is running.  It is probably best to run clickit at off-hours when this is unlikely to happen, or to watch your screen when clickit is running.  We don't take responsibility for errors in signing from clickit -- if you are worried about that, don't run clickit!


Reference

Scriptit download site: http://www.dx21.com/scripting/scriptit/index.asp
Microsoft MS Scripit Utility site: http://www.microsoft.com/technet/archive/winntas/downloads/scriptit.mspx?mfr=true

Revision History

Version 0.4 update
	Added sovera.ini script to allow automatic signing of Sovera documents.

Version 0.3 update
	Added separate Vista and XP allscripts.ini files.  Vista titles IE windows as "Windows Internet Explorer" and XP uses "Microsoft Internet Explorer."

Version 0.2 update

The actual scriptit.exe file was left out of the 0.1 zip file, rendering it useless.  Also fixed the allscripts.ini file and increased the number of Alt-S keystrokes generated.
