; Clickit Version 1.0.0
; Copyright (c) 2010 EP Studios, Inc.
; Distributed under the GPL V3.

#include <GuiConstantsEx.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
	Local $windowTitle, $key, $delay, $numClicks
	Local $fileName
	Local $msg
	Local $WindowTitleLabel, $KeyLabel, $DelayLabel, $NumClicksLabel

	GUICreate("ClickIt!")
	$WindowTitleLabel = GUICtrlCreateLabel("Window Title", 30, 40, 131, 21, 0x1000)
	$KeyLabel = GUICtrlCreateLabel("Key", 30, 60, 130, 21)
	$DelayLabel = GUICtrlCreateLabel("Delay Time (msec)", 30, 90, 130, 20)


	GUISetState()
	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd
	Exit
EndFunc
