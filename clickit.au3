; ClickIt -- a program to automate repetitive signing of computer documents
; Copyright (c) 2010 EP Studios, Inc.

; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.

; Signature icon copyright by
; http://www.iconarchive.com/show/software-icons-by-aha-soft/signature-icon.html
; Icon license is "free for non-commercial use."

; WAV files (beep) copyright by http://www.soundjay.com used with permission.
; These files can only be used within this open source project and
; cannot be used for other purposes.

; Email: mannd@epstudiossoftware.com
; Web site: http://www.epstudiossoftware.com

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#include <GuiComboBox.au3>
#include <Array.au3>

Global Const $VERSION = "1.1.2"
Global Const $MAXARRAYLENGTH = 50
Global Const $HEADING1 = "Settings"
Global Const $SESSIONFILE = "_last.ini"

Global $key = ""
Global $keyDescription
Global $isRunning = False
Global $stopRunning = True
Global $delay
Global $numRepeats
Global $testMode = False
Global $closeWindowWhenDone = False

Global $windowTitleArray[$MAXARRAYLENGTH]
Global $comboCount
Global $beepWhenDone = False
Global $exitOnError = False

Opt("GUIOnEventMode", 1) ; Change to OnEvent mode

;; NB:  using Koda, make sure MainForm position is set to poDesktopCentered.
#Region ### START Koda GUI section ### Form=mainform.kxf
$MainForm = GUICreate("ClickIt", 387, 335, -1, -1)
$MenuItem1 = GUICtrlCreateMenu("&File")
$LoadMenuItem = GUICtrlCreateMenuItem("Load script", $MenuItem1)
$SaveMenuItem = GUICtrlCreateMenuItem("Save script", $MenuItem1)
$MenuItem11 = GUICtrlCreateMenuItem("", $MenuItem1)
$ExitMenuItem = GUICtrlCreateMenuItem("Exit", $MenuItem1)
$MenuItem6 = GUICtrlCreateMenu("&Options")
$TestMenuItem = GUICtrlCreateMenuItem("Test with Notepad", $MenuItem6)
$BeepMenuItem = GUICtrlCreateMenuItem("Beep when done", $MenuItem6)
$MenuItem2 = GUICtrlCreateMenu("&Help")
$HelpMenuItem = GUICtrlCreateMenuItem("ClickIt Help", $MenuItem2)
$AboutMenuItem = GUICtrlCreateMenuItem("About ClickIt", $MenuItem2)
GUISetIcon("c:\users\mannd\dev\git\clickit\signature.ico")
GUISetOnEvent($GUI_EVENT_CLOSE, "MainFormClose")
$RunButton = GUICtrlCreateButton("Run", 296, 272, 75, 33, $WS_GROUP)
GUICtrlSetOnEvent($RunButton, "RunButtonClick")
$WindowTitleCombBox = GUICtrlCreateCombo("WindowTitleCombBox", 8, 4, 241, 25)
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
$Label2 = GUICtrlCreateLabel("Key", 136, 88, 22, 17)
$AsciiKeyValueLabel = GUICtrlCreateLabel("Ascii Key Value", 176, 112, 77, 17)
GUICtrlSetState($AsciiKeyValueLabel, $GUI_HIDE)
$SetButton = GUICtrlCreateButton("Set", 224, 80, 51, 25, $WS_GROUP)
GUICtrlSetOnEvent($SetButton, "KeyValueChange")
$NotificationLabel = GUICtrlCreateLabel("Script is Off", 136, 136, 86, 24)
GUICtrlSetFont($NotificationLabel, 12, 400, 0, "MS Sans Serif")
GUICtrlSetColor($NotificationLabel, 0x008000)
$ClearButton = GUICtrlCreateButton("Clear", 280, 80, 59, 25, $WS_GROUP)
GUICtrlSetOnEvent($ClearButton, "ClearButtonClick")
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
GUICtrlSetOnEvent($CloseWindowCheckBox, "CloseWindowCheckBoxClick")
$AddButton = GUICtrlCreateButton("Add", 256, 0, 51, 25, $WS_GROUP)
GUICtrlSetOnEvent($AddButton, "AddButtonClick")
$DeleteButton = GUICtrlCreateButton("Del", 312, 0, 59, 25, $WS_GROUP)
GUICtrlSetOnEvent($DeleteButton, "DeleteButtonClick")
$ProgressBar = GUICtrlCreateProgress(8, 280, 270, 17)
GUICtrlSetOnEvent($LoadMenuItem, "LoadMenuItemClick")
GUICtrlSetOnEvent($SaveMenuItem, "SaveMenuItemClick")
GUICtrlSetOnEvent($ExitMenuItem, "ExitMenuItemClick")
GUICtrlSetOnEvent($TestMenuItem, "TestMenuItemClick")
GUICtrlSetOnEvent($BeepMenuItem, "BeepMenuItemClick")
GUICtrlSetOnEvent($HelpMenuItem, "HelpMenuItemClick")
GUICtrlSetOnEvent($AboutMenuItem, "AboutMenuItemClick")
GUISetState(@SW_SHOW)
Dim $MainForm_AccelTable[2][2] = [["^q", $ExitMenuItem],["{F1}", $HelpMenuItem]]
GUISetAccelerators($MainForm_AccelTable)
#EndRegion ### END Koda GUI section ###

GUISetIcon("signature.ico")	; hard path above won't work for others

Main()

Func Main()
	; Main script loop
	Local $infinity = False
	Local $n

	; set min here, Koda doesn't do this
	GUICtrlSetLimit($DelayUpDown, 999, 1)
	GUICtrlSetData($DelayInput, 1)

	InitializeWindowTitleComboBox()
	FillWindowTitleComboBox()
	InitializeDialog()
	ParseCommandLine()

	While 1
		$infinity = ($numRepeats = 0)
		$n = $numRepeats
		GUICtrlSetData($ProgressBar, 0)
		While Not $stopRunning
			If $testMode Then
				Send($keyDescription & @CR, 1) ; raw send mode
			Else
				Send($key)
			EndIf
			$n -= 1
			If Not $infinity Then
				GUICtrlSetData($ProgressBar, (100 - (100 * $n/$numRepeats)))
			EndIf
			If Not $infinity And $n <= 0 Then
				If $beepWhenDone Then
					SoundPlay("beep-7.wav")
				EndIf
				GUICtrlSetData($ProgressBar, 100)
				RunButtonClick()
				If $closeWindowWhenDone Then
					MainFormClose()
				EndIf
			Else
				Sleep($delay * 1000)
			EndIf
		WEnd
		Sleep(1000)
	WEnd
EndFunc   ;==>Main

Func InitializeWindowTitleComboBox()
	; some useful defaults for the combo box
	If FileExists("windowlist") Then
		$listFile = FileOpen("windowlist")
		If $listFile <> -1 Then
			$n = 0
			While 1
				$windowTitleArray[$n] = FileReadLine($listFile)
				If @error = -1 Then ExitLoop
				$n += 1
			WEnd
			$comboCount = $n
		EndIf
	Else
		$windowTitleArray[0] = "Allscripts - Windows Internet Explorer"
		$windowTitleArray[1] = "Remote Desktop Web Connection - Windows Internet Explorer"
		$windowTitleArray[2] = "Allscripts - Microsoft Internet Explorer"
		$windowTitleArray[3] = "Remote Desktop Web Connection - Microsoft Internet Explorer"
		$comboCount = 4			; total number of array members
	EndIf
EndFunc   ;==>InitializeWindowTitleComboBox

Func InitializeDialog()
	; some reasonable defaults for first time running
	; after first time, dialog settings are saved
	GUICtrlSetState($AltCheckBox, True)
	GUICtrlSetData($KeyInput, "s")
	GUICtrlSetData($DelayInput, 5)
	GUICtrlSetData($RepeatInput, 30)
	KeyValueChange()	; make sure key variables filled in first time around
EndFunc


Func FillWindowTitleComboBox()
	GUICtrlSetData($WindowTitleCombBox, "|")
	For $i = 0 To $comboCount - 1
		GUICtrlSetData($WindowTitleCombBox, $windowTitleArray[$i])
	Next
	_GUICtrlComboBox_SetEditText($WindowTitleCombBox, $windowTitleArray[0])
EndFunc   ;==>FillWindowTitleComboBox

Func SaveComboBox()
	$listFile = FileOpen("windowlist", 2)
	For $i = 0 To $comboCount - 1
		FileWriteLine($listFile, $windowTitleArray[$i])
	Next
	FileClose($listFile)
EndFunc   ;==>SaveComboBox

Func AddButtonClick()
	$text = GUICtrlRead($WindowTitleCombBox)
	If _ArraySearch($WindowTitleCombBox, $text) = -1 Then
		If $comboCount < $MAXARRAYLENGTH Then
			$comboCount += 1
			$windowTitleArray[$comboCount - 1] = $text
		Else
			_ArrayPush($WindowTitleCombBox, $text)
		EndIf
		FillWindowTitleComboBox()
	EndIf
EndFunc   ;==>AddButtonClick

Func ClearButtonClick()
	GUICtrlSetData($KeyInput, "")
	GUICtrlSetState($AltCheckBox, $GUI_UNCHECKED)
	GUICtrlSetState($CtrlCheckBox, $GUI_UNCHECKED)
	GUICtrlSetState($ShiftCheckBox, $GUI_UNCHECKED)
	GUICtrlSetState($WinCheckBox, $GUI_UNCHECKED)
	GUICtrlSetData($AsciiKeyValueLabel, "")
	$key = ""
	$keyDescription = ""
EndFunc   ;==>ClearButtonClick

Func DeleteButtonClick()
	$text = GUICtrlRead($WindowTitleCombBox)
	If $comboCount > 0 Then
		_ArrayDelete($WindowTitleCombBox, $text)
		$comboCount -= 1
		FillWindowTitleComboBox()
	EndIf
EndFunc   ;==>DeleteButtonClick

Func MainFormClose()
	SaveComboBox()
	SaveScript($SESSIONFILE)
	Exit
EndFunc   ;==>MainFormClose

Func ExitMenuItemClick()
	MainFormClose()
EndFunc   ;==>ExitMenuItemClick

Func TestMenuItemClick()
	If BitAND(GUICtrlRead($TestMenuItem), $GUI_CHECKED) = $GUI_CHECKED Then
		GUICtrlSetState($TestMenuItem, $GUI_UNCHECKED)
		$testMode = False
	Else
		GUICtrlSetState($TestMenuItem, $GUI_CHECKED)
		$testMode = True
	EndIf
EndFunc   ;==>TestMenuItemClick

Func BeepMenuItemClick()
	If BitAND(GUICtrlRead($BeepMenuItem), $GUI_CHECKED) = $GUI_CHECKED Then
		GUICtrlSetState($BeepMenuItem, $GUI_UNCHECKED)
		$beepWhenDone = False
	Else
		GUICtrlSetState($BeepMenuItem, $GUI_CHECKED)
		$beepWhenDone = True
	EndIf
EndFunc   ;==>BeepMenuItemClick

Func CloseWindowCheckBoxClick()
	$closeWindowWhenDone = GUICtrlRead($CloseWindowCheckBox) = $GUI_CHECKED
EndFunc   ;==>CloseWindowCheckBoxClick

Func AboutMenuItemClick()
	MsgBox(64, "About ClickIt", "ClickIt Version " & $VERSION & _
			@CRLF & @CRLF & "Copyright (c) 2010 EP Studios, Inc." & _
			@CRLF & "http://www.epstudiossoftware.com")
	; 64 = OK button and Info icon
EndFunc   ;==>AboutMenuItemClick

Func HelpMenuItemClick()
	MsgBox(64, "ClickIt Help", _
			"Match the Window Title Bar exactly (case sensitive).  " & _
			@CRLF & "Select the key with modifier (e.g. Alt-s)." & _
			@CRLF & "Select the delay and number of " & _
			"times to repeat (0 = infinity)." & _
			@CRLF & "Click Run to go." & _
	@CRLF & "See README.markdown for more details.")
EndFunc   ;==>HelpMenuItemClick

Func KeyValueChange()
	$key = GUICtrlRead($KeyInput)
	$keyDescription = $key
	If GUICtrlRead($AltCheckBox) = $GUI_CHECKED Then
		$key = "!" & $key
		$keyDescription = "Alt+" & $keyDescription
	EndIf
	If GUICtrlRead($CtrlCheckBox) = $GUI_CHECKED Then
		$key = "^" & $key
		$keyDescription = "Ctrl+" & $keyDescription
	EndIf
	If GUICtrlRead($ShiftCheckBox) = $GUI_CHECKED Then
		$key = "+" & $key
		$keyDescription = "Shift+" & $keyDescription
	EndIf
	If GUICtrlRead($WinCheckBox) = $GUI_CHECKED Then
		$key = "#" & $key
		$keyDescription = "Win+" & $keyDescription
	EndIf
	GUICtrlSetState($AsciiKeyValueLabel, $GUI_SHOW)
	GUICtrlSetData($AsciiKeyValueLabel, $keyDescription)
EndFunc   ;==>KeyValueChange

Func ConvertSpecialKeys()
	Select
		Case $key = "!"
			$key = "{!}"
		Case $key = "#"
			$key = "{#}"
		Case $key = "+"
			$key = "{+}"
		Case $key = "^"
			$key = "{^}"
	EndSelect
EndFunc

Func RunButtonClick()
	If $isRunning Then
		GUICtrlSetData($RunButton, "Run")
		GUICtrlSetColor($NotificationLabel, 0x008000) ; green
		GUICtrlSetData($NotificationLabel, "Script Is Off")
		$isRunning = False
		$stopRunning = True
		If $testMode Then
			CloseNotePad()
		EndIf
		Sleep(500)	; provide a little delay to update the progress bar
		GUICtrlSetData($ProgressBar, 0)	; now make progress go to zero
	Else
		GUICtrlSetData($RunButton, "Stop")
		GUICtrlSetColor($NotificationLabel, 0xff0000) ; red
		GUICtrlSetData($NotificationLabel, "Running Script")
		SetRunParameters()
		$isRunning = True
		$stopRunning = False
		If $testMode Then
			OpenNotePad()
		Else
			ActivateWindow()
		EndIf
	EndIf
EndFunc   ;==>RunButtonClick

Func SetRunParameters()
	$delay = GUICtrlRead($DelayInput)
	$numRepeats = GUICtrlRead($RepeatInput)
EndFunc   ;==>SetRunParameters

Func ActivateWindow()
	$title = GUICtrlRead($WindowTitleCombBox)
	WinActivate($title)
	If Not WinActive($title) Then
		MsgBox(48, "Can't Activate Window", _
				$title & " cannot be activated")
		RunButtonClick() ; shuts it off
		If $exitOnError Then
			MainFormClose()
		EndIf
	EndIf
EndFunc   ;==>ActivateWindow

Func OpenNotePad()
	Run("notepad.exe")
	WinWaitActive("Untitled - Notepad")
	Send("ClickIt Notepad Test" & @CRLF)
	$activeWindow = GUICtrlRead($WindowTitleCombBox)
	Send("Target window title is " & $activeWindow & @CR)
	Send("Key sent to " & $activeWindow & " is" & @CR)
EndFunc   ;==>OpenNotePad

Func CloseNotePad()
	If WinClose("Untitled - Notepad") Then ; in case user closed it first
		WinWaitActive("Notepad", "Cancel")
		Send("!n")
	EndIf
EndFunc   ;==>CloseNotePad

Func SaveMenuItemClick()
	$file = FileSaveDialog("Save Script", ".", "Scripts (*.ini)|All files (*.*)")
	If Not @error Then
		If Not (StringUpper(StringRight($file, 4)) = ".INI") Then
			$file = $file & ".ini"
		EndIf
		SaveScript($file)
	EndIf
EndFunc   ;==>SaveMenuItemClick

Func SaveScript($file)
	IniWrite($file, $HEADING1, "title", GUICtrlRead($WindowTitleCombBox))
	IniWrite($file, $HEADING1, "key", GUICtrlRead($KeyInput))
	IniWrite($file, $HEADING1, "alt", GUICtrlRead($AltCheckBox))
	IniWrite($file, $HEADING1, "ctrl", GUICtrlRead($CtrlCheckBox))
	IniWrite($file, $HEADING1, "shift", GUICtrlRead($ShiftCheckBox))
	IniWrite($file, $HEADING1, "win", GUICtrlRead($WinCheckBox))
	IniWrite($file, $HEADING1, "delay", GUICtrlRead($DelayInput))
	IniWrite($file, $HEADING1, "numrepeats", GUICtrlRead($RepeatInput))
	IniWrite($file, $HEADING1, "closewhendone", GUICtrlRead($CloseWindowCheckBox))
EndFunc   ;==>SaveScript


Func LoadMenuItemClick()
	$file = FileOpenDialog("Load Script", ".", _
			"Scripts (*.ini)|All files (*.*)")
	If Not @error Then
		LoadScript($file)
	EndIf
EndFunc   ;==>LoadMenuItemClick

Func LoadScript($file)
	GUICtrlSetData($WindowTitleCombBox, IniRead($file, $HEADING1, "title", ""))
	GUICtrlSetData($KeyInput, IniRead($file, $HEADING1, "key", ""))
	GUICtrlSetState($AltCheckBox, IniRead($file, $HEADING1, "alt", $GUI_UNCHECKED))
	GUICtrlSetState($CtrlCheckBox, IniRead($file, $HEADING1, "ctrl", $GUI_UNCHECKED))
	GUICtrlSetState($ShiftCheckBox, IniRead($file, $HEADING1, "shift", $GUI_UNCHECKED))
	GUICtrlSetState($WinCheckBox, IniRead($file, $HEADING1, "win", $GUI_UNCHECKED))
	GUICtrlSetData($DelayInput, IniRead($file, $HEADING1, "delay", 1))
	GUICtrlSetData($RepeatInput, IniRead($file, $HEADING1, "numrepeats", 0))
	GUICtrlSetState($CloseWindowCheckBox, IniRead($file, $HEADING1, "closewhendone", $GUI_UNCHECKED))
	KeyValueChange()
	CloseWindowCheckBoxClick() ; sets $closeWindowWhenDone
EndFunc   ;==>LoadScript

Func PrintUsage()
	MsgBox(64, "Clickit Usage", _
			"Usage:" & @LF & _
			"   clickit [options] [ini file]" & @LF & _
			"Example:" & @LF & _
			"   clickit -q allscripts.ini" & @CRLF)
EndFunc   ;==>PrintUsage

Func ParseCommandLine()
	If $CmdLine[0] = 0 Then
		If FileExists($SESSIONFILE) Then
			LoadScript($SESSIONFILE)
		EndIf
	EndIf
	If $CmdLine[0] > 0 Then
		$quietMode = False
		$switch = StringUpper($CmdLine[1])
		If $switch = "-H" Or $switch = "--HELP" Then
			GUISetState(@SW_HIDE)
			PrintUsage()
			MainFormClose()
		EndIf
		If StringUpper($CmdLine[1]) = "--VERSION" Then
			GUISetState(@SW_HIDE)
			AboutMenuItemClick()
			MainFormClose()
		EndIf
		If StringUpper($CmdLine[1]) = "-Q" Then
			GUISetState(@SW_HIDE)
			$exitOnError = True
			$quietMode = True
		EndIf
		If StringUpper($CmdLine[1]) = "-V" Then
			; set verbose mode which is default
		EndIf
		If FileExists($CmdLine[$CmdLine[0]]) Then
			LoadScript($CmdLine[$CmdLine[0]])
			If $quietMode Then	; force close
				GUICtrlSetData($closeWindowWhenDone, True)
				$closeWindowWhenDone = True
			EndIf
			RunButtonClick()
		EndIf
	EndIf
EndFunc   ;==>ParseCommandLine
