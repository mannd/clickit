; ClickIt! Copyright (c) 2010 EP Studios, Inc.
; Version 1.0.0
; License GPL Version 3
; icon from http://www.iconarchive.com/show/software-icons-by-aha-soft/signature-icon.html
; icon license "free for non-commercial use."


#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Dim $version = "1.0.0"
Dim $key= ' '
Dim $keyDescription
Dim $isRunning = False
Dim $stopRunning = True
Dim $delay
Dim $numRepeats

Opt("GUIOnEventMode", 1)  ; Change to OnEvent mode
#Region ### START Koda GUI section ### Form=mainform.kxf
$MainForm = GUICreate("ClickIt", 384, 340, 1085, 474)
$MenuItem1 = GUICtrlCreateMenu("&File")
$MenuItem12 = GUICtrlCreateMenuItem("Load script", $MenuItem1)
$MenuItem13 = GUICtrlCreateMenuItem("Save script", $MenuItem1)
$MenuItem9 = GUICtrlCreateMenuItem("Load settings", $MenuItem1)
$MenuItem10 = GUICtrlCreateMenuItem("Save settings", $MenuItem1)
$MenuItem11 = GUICtrlCreateMenuItem("", $MenuItem1)
$ExitMenuItem = GUICtrlCreateMenuItem("Exit", $MenuItem1)
$MenuItem6 = GUICtrlCreateMenu("&Run")
$RunMenuItem = GUICtrlCreateMenuItem("Run", $MenuItem6)
$TestMenuItem = GUICtrlCreateMenuItem("Test with Notepad", $MenuItem6, -1 , 1)
$MenuItem2 = GUICtrlCreateMenu("&Help")
$HelpMenuItem = GUICtrlCreateMenuItem("ClickIt! Help", $MenuItem2)
$AboutMenuItem = GUICtrlCreateMenuItem("About ClickIt!", $MenuItem2)
GUISetIcon("C:\Users\mannd\dev\git\clickit\AutoIt\signature.ico")
GUISetOnEvent($GUI_EVENT_CLOSE, "MainFormClose")
$RunDefaultButton = GUICtrlCreateButton("Run Default", 208, 280, 75, 25, $WS_GROUP)
$RunButton = GUICtrlCreateButton("Run", 296, 280, 75, 25, $WS_GROUP)
GUICtrlSetOnEvent($RunButton, "RunButtonClick")
$WindowTitleCombBox = GUICtrlCreateCombo("WindowTitleCombBox", 104, 4, 265, 25)
$Label1 = GUICtrlCreateLabel("Window Title Bar", 8, 8, 85, 17)
$Group1 = GUICtrlCreateGroup("Signature Key", 8, 32, 361, 145)
$AltCheckBox = GUICtrlCreateCheckbox("Alt", 24, 56, 97, 17)
GUICtrlSetOnEvent($AltCheckBox, "KeyValueChange")
$CtrlCheckBox = GUICtrlCreateCheckbox("Ctrl", 24, 80, 97, 17)
GUICtrlSetOnEvent($CtrlCheckBox, "KeyValueChange")
$ShiftCheckBox = GUICtrlCreateCheckbox("Shift", 24, 104, 97, 17)
GUICtrlSetOnEvent($ShiftCheckBox, "KeyValueChange")
$WinCheckBox = GUICtrlCreateCheckbox("Win", 24, 128, 97, 17)
GUICtrlSetOnEvent($WinCheckBox, "KeyValueChange")
$KeyInput = GUICtrlCreateInput("", 176, 80, 33, 21)
GUICtrlSetLimit($KeyInput, 1)
GUICtrlSetOnEvent($KeyInput, "KeyValueChange")
$Label2 = GUICtrlCreateLabel("Key", 176, 64, 22, 17)
$AsciiKeyValueLabel = GUICtrlCreateLabel("Ascii Key Value", 176, 112, 77, 17)
GUICtrlSetState($AsciiKeyValueLabel, $GUI_HIDE)
$SetButton = GUICtrlCreateButton("Set", 224, 80, 51, 25, $WS_GROUP)
GUICtrlSetOnEvent($SetButton, "KeyValueChange")
$NotificationLabel = GUICtrlCreateLabel("Script is Off", 176, 136, 86, 24)
GUICtrlSetFont($NotificationLabel, 12, 400, 0, "MS Sans Serif")
GUICtrlSetColor($NotificationLabel, 0x008000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$DelayInput = GUICtrlCreateInput("0", 160, 192, 73, 21)
$DelayUpDown = GUICtrlCreateUpdown($DelayInput)
GUICtrlSetLimit($DelayUpDown, 999, 0)
$Label4 = GUICtrlCreateLabel("Delay between clicks (sec)", 8, 192, 131, 17)
$RepeatInput = GUICtrlCreateInput("0", 160, 224, 73, 21)
$RepeatUpDown = GUICtrlCreateUpdown($RepeatInput)
GUICtrlSetLimit($RepeatUpDown, 999, 0)
$Label5 = GUICtrlCreateLabel("Number of repeats (0 = infinity)", 8, 224, 147, 17)
$CloseWindowCheckBox = GUICtrlCreateCheckbox("Close this window when done", 8, 256, 217, 17)
GUICtrlSetOnEvent($ExitMenuItem, "ExitMenuItemClick")
GUICtrlSetOnEvent($TestMenuItem, "TestMenuItemClick")
GUICtrlSetOnEvent($HelpMenuItem, "HelpMenuItemClick")
GUICtrlSetOnEvent($AboutMenuItem, "AboutMenuItemClick")
GUISetState(@SW_SHOW)
Dim $MainForm_AccelTable[3][2] = [["^q", $ExitMenuItem],["{F5}", $RunMenuItem],["{F1}", $HelpMenuItem]]
GUISetAccelerators($MainForm_AccelTable)
#EndRegion ### END Koda GUI section ###


GUICtrlSetLimit($DelayUpDown, 999, 1)	; set min here, Koda doesn't do this right
GUICtrlSetData($DelayInput, 1)
While 1
	While Not $stopRunning
		; run main script here
		Send($keyDescription & @CR)
		Sleep($delay * 1000)
	WEnd
	Sleep(100)
WEnd

Func MainFormClose()
	Exit
EndFunc

Func ExitMenuItemClick()
	MainFormClose()
EndFunc

Func TestMenuItemClick()
EndFunc

Func AboutMenuItemClick()
	MsgBox(64, "About ClickIt", "ClickIt Version " & $version & _
	@CR & "Copyright (c) 2010 EP Studios, Inc." & _
	@CR & "http://www.epstudiossoftware.com")	; 64 = OK button and Info icon
EndFunc

Func HelpMenuItemClick()
	MsgBox(64, "ClickIt Help", _
	"Simple Help: Match the Window Title Bar exactly (case sensistive).  " & _
	@CRLF & "Select the key with modifier (e.g. Alt-s)."  & _
	@CRLF & "Select the delay and number of "  & _
	"times to repeat (0 = infinity), and then click Run to go.")
EndFunc



Func KeyValueChange()
	$key = GUICtrlRead($KeyInput)
	$keyDescription = $key
	if GUICtrlRead($AltCheckBox) = $GUI_CHECKED Then
		$key = "!" & $key
		$keyDescription = "Alt+" & $keyDescription
	EndIf
	if GUICtrlRead($CtrlCheckBox) = $GUI_CHECKED Then
		$key = "^" & $key
		$keyDescription = "Ctrl+" & $keyDescription
	EndIf
		if GUICtrlRead($ShiftCheckBox) = $GUI_CHECKED Then
		$key = "+" & $key
		$keyDescription = "Shift+" & $keyDescription
	EndIf
	if GUICtrlRead($WinCheckBox) = $GUI_CHECKED Then
		$key = "#" & $key
		$keyDescription = "Win+" & $keyDescription
	EndIf
	GUICtrlSetState($AsciiKeyValueLabel, $GUI_SHOW)
	GUICtrlSetData($AsciiKeyValueLabel, $keyDescription)
EndFunc

Func RunButtonClick ()
	If $isRunning Then
		GUICtrlSetData($RunButton, "Run")
		GUICtrlSetColor($NotificationLabel, 0x008000)	; green
		GUICtrlSetData($NotificationLabel, "Script Is Off")
		$isRunning = False
		$stopRunning = True
		SetRunParameters()
		CloseNotePad()
	Else
		GUICtrlSetData($RunButton, "Stop")
		GUICtrlSetColor($NotificationLabel, 0xff0000)	; red
		GUICtrlSetData($NotificationLabel, "Running Script")
		$isRunning = True
		$stopRunning = False
		SetRunParameters()
		OpenNotePad()
	EndIf
EndFunc

Func SetRunParameters()
	$delay = GUICtrlRead($DelayInput)
	$numRepeats = GUICtrlRead($RepeatInput)
EndFunc

Func OpenNotePad()
	Run("notepad.exe")
	WinWaitActive("Untitled - Notepad")
	Send("ClickIt Notepad Test" & @CRLF)
EndFunc

Func CloseNotePad()
	If WinClose("Untitled - Notepad") Then	; in case user closed it first
		WinWaitActive("Notepad", "Cancel")
		Send("!n")
	EndIf
EndFunc









