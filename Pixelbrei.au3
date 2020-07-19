#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Pixelbrei 3.0 x86.exe
#AutoIt3Wrapper_Outfile_x64=P Me x64.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Fileversion=1.0.0.1
#AutoIt3Wrapper_Res_ProductVersion=3.0
#AutoIt3Wrapper_Res_File_Add=pixel_.jpg, RT_RCDATA, JPG_1, 0
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/pe /sf /sv /rm
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;*****************************************
;Pixelbrei.au3 by Zeeeds
;Erstellt mit ISN AutoIt Studio v. 1.11
;*****************************************
#include <Misc.au3>
#include <onEventFunc.au3>
#include <ResourcesEx.au3>

HotKeySet("{F1}", "ScanData")
HotKeySet("{F2}", "SelectScan")

Local $hDLL = DllOpen("user32.dll")
Local $Data[16][80], $ScanData[16][80], $CoordDataX[16][80], $CoordDataY[16][80], $X = 10, $Y = 18, $ClickVarR, $ClickVarS, $Lock, $IsSet[4], $MemoryXyXy[2][4], $ProfilSwitch, $KColor = 12262439, $Plus, $Window, $Self
Local $PToken[3]
$PToken[0] = "Pixelbrei"
$PToken[1] = "3.0"
$PToken[2] = "Pixelbrei export"
Local $T[2]
$T[0] = Random(1000, 9000, 1)
$T[1] = Random(1, 999, 1)

; -- Created with ISN Form Studio 2 for ISN AutoIt Studio -- ;
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <GuiButton.au3>
#include <EditConstants.au3>

Opt("GUIOnEventMode", 1)
Local $PGUI = GUICreate($T[0] & $T[1],565,1020,-1,-1,BitOr($WS_SYSMENU,$WS_MINIMIZEBOX,$WS_VISIBLE),-1)
GUISetOnEvent($GUI_EVENT_CLOSE, "Terminate", $PGUI)
Local $GUIBGimage = GUICtrlCreatePic("", 0, 0, 565, 1010, $WS_CLIPSIBLINGS)
_Resource_SetToCtrlID($GUIBGimage, 'JPG_1')
For $r = 0 To 15
	If $r = 0 Then
		GUICtrlCreateGroup("Left/Top X,Y", $X, $Y - 15, 200, 980)
	ElseIf $r = 8 Then
		$X = $X + 2
		GUICtrlCreateGroup("Right/Bottom X,Y", $X, $Y - 15, 200, 980)
	EndIf
	For $s = 0 To 79
		$Data[$r][$s] = GUICtrlCreateRadio("", $X, $Y, 25, 12, -1, -1)
		SetOnEventA(-1, "DataClick", $paramByVal, $r, $paramByVal, $s)
		GUICtrlSetBkColor($Data[$r][$s], "0xC0C0C0")
		$Y = $Y + 12
	Next
	$X = $X + 25
	$Y = 18
Next
Local $CInput = GUICtrlCreateInput("",425,703,100,20,BitOr($ES_CENTER,$ES_READONLY),$WS_EX_CLIENTEDGE)
GUICtrlSetOnEvent(-1,"ColorSwitch")
GUICtrlSetTip(-1,"Color HEX code.")
GUICtrlCreateLabel("Color",425,683,125,20,$SS_CENTER,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"-2")
Local $LXInput = GUICtrlCreateInput("",430,754,30,20,BitOr($ES_CENTER,$ES_READONLY),$WS_EX_CLIENTEDGE)
GUICtrlSetTip(-1,"Upper left corner from where to search.")
GUICtrlCreateLabel("Zeeeds Pixelbrei V3.0",425,8,125,50,$SS_CENTER,-1)
GUICtrlSetFont(-1,13,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"-2")
Local $CDisplay = GUICtrlCreateLabel("C",525,703,25,20,$SS_CENTER,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetColor(-1,"0xFF00FF")
GUICtrlSetBkColor(-1,"0")
GUICtrlCreateLabel("Y",462,784,16,20,-1,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"-2")
Local $LYInput = GUICtrlCreateInput("",430,784,30,20,BitOr($ES_CENTER,$ES_READONLY),$WS_EX_CLIENTEDGE)
GUICtrlSetTip(-1,"Upper left corner from where to search.")
GUICtrlCreateGroup("Right",490,723,60,90,-1,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"0xF0F0F0")
GUICtrlCreateLabel("X",462,754,16,20,-1,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"-2")
Local $RXInput = GUICtrlCreateInput("",497,754,30,20,BitOr($ES_CENTER,$ES_READONLY),$WS_EX_CLIENTEDGE)
GUICtrlSetTip(-1,"Bottom right corner where the search ends.")
GUICtrlCreateGroup("Left",423,723,60,90,-1,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"0xF0F0F0")
Local $RYInput = GUICtrlCreateInput("",497,784,30,20,BitOr($ES_CENTER,$ES_READONLY),$WS_EX_CLIENTEDGE)
GUICtrlSetTip(-1,"Bottom right corner where the search ends.")
GUICtrlCreateLabel("Y",530,784,16,20,-1,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"-2")
GUICtrlCreateLabel("X",527,754,16,20,-1,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"-2")
GUICtrlCreateLabel("X",465,95,20,20,-1,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"-2")
GUICtrlCreateLabel("Y",528,95,20,20,-1,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"-2")
Local $SOInputY = GUICtrlCreateInput("30",499,95,30,20,-1,$WS_EX_CLIENTEDGE)
Local $DName = GUICtrlCreateInput("Pixelbrei",425,884,125,20,$ES_CENTER,$WS_EX_CLIENTEDGE)
Local $SOInputX = GUICtrlCreateInput("8",435,95,30,20,-1,$WS_EX_CLIENTEDGE)
GUICtrlCreateButton("Load",425,904,50,25,-1,-1)
GUICtrlSetOnEvent(-1,"LoadData")
GUICtrlSetFont(-1,9,700,2,"Comic Sans MS")
GUICtrlCreateButton("Save",500,904,50,25,-1,-1)
GUICtrlSetOnEvent(-1,"SaveData")
GUICtrlSetFont(-1,9,700,2,"Comic Sans MS")
GUICtrlCreateButton("Kaffeepause Save",425,929,125,25,-1,-1)
GUICtrlSetOnEvent(-1,"SaveData2")
GUICtrlSetFont(-1,9,700,2,"Comic Sans MS")
GUICtrlCreateGroup("Profile",425,813,125,50,$BS_CENTER,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"0xF0F0F0")
Local $P1Button = GUICtrlCreateRadio("<-1- Profile -2->",430,833,100,20,$BS_CENTER,-1)
GUICtrlSetState(-1,BitOr($GUI_CHECKED,$GUI_SHOW,$GUI_DISABLE))
GUICtrlSetFont(-1,8,400,0,"Comic Sans MS")
GUICtrlSetTip(-1,"Press 1 or 2.")
Local $P2Button = GUICtrlCreateRadio("",530,835,15,20,-1,-1)
GUICtrlSetState(-1,BitOr($GUI_UNCHECKED,$GUI_SHOW,$GUI_DISABLE))
GUICtrlSetTip(-1,"Press 1 or 2.")
GUICtrlCreateButton("Open help.txt file",425,954,125,25,-1,-1)
GUICtrlSetOnEvent(-1,"HelpTxT")
GUICtrlSetFont(-1,9,700,2,"Comic Sans MS")
GUICtrlCreateGroup("Filename",423,863,129,120,$BS_CENTER,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"0xF0F0F0")
Local $Subtract = GUICtrlCreateCheckbox("Subtract",435,115,84,20,$BS_CENTER,-1)
GUICtrlSetOnEvent(-1,"IsSubtract")
GUICtrlSetState(-1,BitOr($GUI_CHECKED,$GUI_SHOW,$GUI_ENABLE))
GUICtrlSetFont(-1,8,700,0,"Comic Sans MS")
GUICtrlCreateGroup("Scan offset",425,65,125,75,$BS_CENTER,-1)
GUICtrlSetFont(-1,10,700,2,"Comic Sans MS")
GUICtrlSetBkColor(-1,"0xF0F0F0")

GUISetState(@SW_SHOW)
$Self = WinGetHandle("[active]")
rdyBeep()

While 1
	While $Self = WinGetHandle("[active]")
		If _IsPressed("72", $hDLL) = True Then
			ProfilSwitch()
		EndIf
		Sleep(50)
	WEnd
	Sleep(50)
WEnd

Func ScanData()
	If $Lock = True Then
		Return
	EndIf
	$Lock = Not $Lock
	ClickBeep()
	$Window = WinGetHandle("[active]")
	If @error Then
		MsgBox(4096, "Error", "Could not find the correct window", 5)
		ClickBeep()
		$Lock = Not $Lock
		Return
	Else
		WinMove($Window, "", 0, 0)
		Dim $size = WinGetClientSize($Window)
		Dim $xPosi = $size[0] / 2
		Dim $yPosi = $size[1] / 2
		If $Plus = True Then
			$xPosi = $xPosi + GUICtrlRead($SOInputX)
			$yPosi = $yPosi + GUICtrlRead($SOInputY)
		Else
			$xPosi = $xPosi - GUICtrlRead($SOInputX)
			$yPosi = $yPosi - GUICtrlRead($SOInputY)
		EndIf
		For $r = 0 To 15
			For $s = 0 To 79
				$CoordDataX[$r][$s] = Int($xPosi)
				$CoordDataY[$r][$s] = Int($yPosi)
				$ScanData[$r][$s] = PixelGetColor($xPosi, $yPosi, $Window)
				GUICtrlSetBkColor($Data[$r][$s], $ScanData[$r][$s])
				$yPosi = $yPosi + 1
			Next
			$xPosi = $xPosi + 1
			$yPosi = $size[1] / 2
			If $Plus = True Then
				$yPosi = $yPosi + GUICtrlRead($SOInputY)
			Else
				$yPosi = $yPosi - GUICtrlRead($SOInputY)
			EndIf
		Next
		rdyBeep()
	EndIf
	$Lock = Not $Lock
EndFunc   ;==>ScanData

Func SelectScan()
	If $Lock = True Then
		Return
	EndIf
	If $IsSet[0] = False Or $IsSet[2] = False Then
		Return
	EndIf
	ClickBeep()
	$Lock = Not $Lock
	$Window = WinGetHandle("[active]")
	If @error Then
		MsgBox(4096, "Error", "Could not find the correct window", 5)
		ClickBeep()
		$Lock = Not $Lock
		Return
	Else
		WinMove($Window, "", 0, 0)
		Dim $size = WinGetClientSize($Window)
		Dim $xPosi = $size[0] / 2
		Dim $yPosi = $size[1] / 2
		If $Plus = True Then
			$xPosi = $xPosi + GUICtrlRead($SOInputX)
			$yPosi = $yPosi + GUICtrlRead($SOInputY)
		Else
			$xPosi = $xPosi - GUICtrlRead($SOInputX)
			$yPosi = $yPosi - GUICtrlRead($SOInputY)
		EndIf
		For $r = 0 To 15
			For $s = 0 To 79
				If $r >= $IsSet[0] And $s >= $IsSet[1] And $r <= $IsSet[2] And $s <= $IsSet[3] Then
					$CoordDataX[$r][$s] = Int($xPosi)
					$CoordDataY[$r][$s] = Int($yPosi)
					$ScanData[$r][$s] = PixelGetColor($xPosi, $yPosi, $Window)
					GUICtrlSetBkColor($Data[$r][$s], $ScanData[$r][$s])
					$yPosi = $yPosi + 1
				Else
					$yPosi = $yPosi + 1
				EndIf
			Next
			$xPosi = $xPosi + 1
			$yPosi = $size[1] / 2
			If $Plus = True Then
				$yPosi = $yPosi + GUICtrlRead($SOInputY)
			Else
				$yPosi = $yPosi - GUICtrlRead($SOInputY)
			EndIf
		Next
		If $Self <> $Window Then
			MouseWheel("down", 1)
		EndIf
		rdyBeep()
	EndIf
	$Lock = Not $Lock
EndFunc   ;==>SelectScan

Func ColorSwitch()
	GUICtrlSetBkColor($CDisplay, GUICtrlRead($CInput))
	ClickBeep()
EndFunc   ;==>ColorSwitch

Func DataClick($ClickVarR, $ClickVarS)
	If $ClickVarR < 8 Then
		GUICtrlSetData($LXInput, $CoordDataX[$ClickVarR][$ClickVarS])
		GUICtrlSetData($LYInput, $CoordDataY[$ClickVarR][$ClickVarS])
		GUICtrlSetData($CInput, $ScanData[$ClickVarR][$ClickVarS])
		$IsSet[0] = $ClickVarR
		$IsSet[1] = $ClickVarS
		For $r = 8 To 15
			For $s = 0 To 79
				If $s >= $ClickVarS And GUICtrlGetState($Data[$r][$s]) = 144 Then
					GUICtrlSetState($Data[$r][$s], $GUI_ENABLE)
				EndIf
				If $s < $ClickVarS And GUICtrlGetState($Data[$r][$s]) = 80 Then
					GUICtrlSetState($Data[$r][$s], $GUI_DISABLE)
				EndIf
			Next
		Next
	Else
		GUICtrlSetData($RXInput, $CoordDataX[$ClickVarR][$ClickVarS])
		GUICtrlSetData($RYInput, $CoordDataY[$ClickVarR][$ClickVarS])
		GUICtrlSetData($CInput, $ScanData[$ClickVarR][$ClickVarS])
		$IsSet[2] = $ClickVarR
		$IsSet[3] = $ClickVarS
		For $r = 0 To 7
			For $s = 0 To 79
				If $s <= $ClickVarS And GUICtrlGetState($Data[$r][$s]) = 144 Then
					GUICtrlSetState($Data[$r][$s], $GUI_ENABLE)
				EndIf
				If $s > $ClickVarS And GUICtrlGetState($Data[$r][$s]) = 80 Then
					GUICtrlSetState($Data[$r][$s], $GUI_DISABLE)
				EndIf
			Next
		Next
	EndIf
	ColorSwitch()
EndFunc   ;==>DataClick

Func SaveData()
	ClickBeep()
	If $ScanData[15][79] = False Then
		MsgBox(0, "Error", "Do a scan first.", 3)
		ClickBeep()
		Return
	EndIf
	Local $nFile = "PB" & "_" & GUICtrlRead($DName) & "." & @YEAR & @MON & @MDAY & "." & @HOUR & @MIN & @SEC & ".sav"
	Local $hFile = FileOpen(@ScriptDir & '\' & $nFile, $FO_READ + $FO_OVERWRITE + $FO_BINARY)
	If $hFile = -1 Then
		MsgBox(0, "Error", "Unable to open file.", 3)
		ClickBeep()
		Return
	Else
		FileWrite($hFile, $PToken[0] & @CRLF)
		FileWrite($hFile, $PToken[1] & @CRLF)
		FileWrite($hFile, GUICtrlRead($SOInputX) & @CRLF)
		FileWrite($hFile, GUICtrlRead($SOInputY) & @CRLF)
		For $r = 0 To 15
			For $s = 0 To 79
				FileWrite($hFile, $CoordDataX[$r][$s] & @CRLF)
				FileWrite($hFile, $CoordDataY[$r][$s] & @CRLF)
				FileWrite($hFile, $ScanData[$r][$s] & @CRLF)
			Next
		Next
	EndIf
	FileClose($hFile)
	rdyBeep()
EndFunc   ;==>SaveData

Func SaveData2()
	ClickBeep()
	Local $nFile = "PIXELKAFFEE" & "_" & GUICtrlRead($DName) & "." & @HOUR & @MIN & @SEC & ".save"
	Local $hFile = FileOpen(@ScriptDir & '\' & $nFile, $FO_READ + $FO_OVERWRITE + $FO_BINARY)
	If $hFile = -1 Then
		MsgBox(0, "Error", "Unable to open file.", 3)
		ClickBeep()
		Return
	Else
		FileWrite($hFile, $PToken[2] & @CRLF)
		FileWrite($hFile, $PToken[1] & @CRLF)
		If $MemoryXyXy[0][0] = False Then
			If GUICtrlRead($LXInput) = False Then
				For $r = 1 To 8
					FileWrite($hFile, "0" & @CRLF)
				Next
			Else
				FileWrite($hFile, GUICtrlRead($LXInput) & @CRLF)
				FileWrite($hFile, GUICtrlRead($LYInput) & @CRLF)
				FileWrite($hFile, GUICtrlRead($RXInput) & @CRLF)
				FileWrite($hFile, GUICtrlRead($RYInput) & @CRLF)
				For $s = 1 To 4
					FileWrite($hFile, "0" & @CRLF)
				Next
			EndIf
		ElseIf $MemoryXyXy[1][0] = False Then
			For $s = 0 To 3
				FileWrite($hFile, $MemoryXyXy[0][$s] & @CRLF)
			Next
			If GUICtrlRead($LXInput) = False Then
				For $s = 1 To 4
					FileWrite($hFile, "0" & @CRLF)
				Next
			Else
				FileWrite($hFile, GUICtrlRead($LXInput) & @CRLF)
				FileWrite($hFile, GUICtrlRead($LYInput) & @CRLF)
				FileWrite($hFile, GUICtrlRead($RXInput) & @CRLF)
				FileWrite($hFile, GUICtrlRead($RYInput) & @CRLF)
			EndIf
		Else
			For $r = 0 To 1
				For $s = 0 To 3
					FileWrite($hFile, $MemoryXyXy[$r][$s] & @CRLF)
				Next
			Next
		EndIf
		If GUICtrlRead($CInput) = False Then
			FileWrite($hFile, $KColor & @CRLF)
		Else
			FileWrite($hFile, GUICtrlRead($CInput) & @CRLF)
		EndIf
		FileWrite($hFile, "50" & @CRLF)
		FileWrite($hFile, "60" & @CRLF)
		FileWrite($hFile, "40" & @CRLF)
		FileWrite($hFile, "02" & @CRLF)
		FileWrite($hFile, "2" & @CRLF)
		FileWrite($hFile, "2")
	EndIf
	FileClose($hFile)
	rdyBeep()
EndFunc   ;==>SaveData2

Func LoadData()
	ClickBeep()
	Local $Folder = @ScriptDir
	Local $var = FileOpenDialog("Choose a File.", $Folder & "\", "Save (*.sav)", $FO_READ + $FO_BINARY)
	If @error Then
		MsgBox(4096, "", "No File chosen", 3)
		ClickBeep()
		Return
	Else
		$var = StringReplace($var, "|", @CRLF)
		Local $hFile = FileOpen($var, 16)
		If $hFile = -1 Then
			MsgBox(0, "Error", "Unable to open file.", 3)
			ClickBeep()
			Return
		Else
			Local $tempPToken[2]
			$tempPToken[0] = FileReadLine($hFile)
			$tempPToken[1] = FileReadLine($hFile)
			If $PToken[0] <> $tempPToken[0] Then
				FileClose($hFile)
				MsgBox(0, "Error", "This is not a Pixelbrei save file.", 3)
				ClickBeep()
				Return
			EndIf
			If $PToken[1] <> $tempPToken[1] Then
				FileClose($hFile)
				MsgBox(0, "Error", "The save file is for " & $tempPToken[0] & " V" & $tempPToken[1] & ".", 3)
				ClickBeep()
				Return
			EndIf
			GUICtrlSetData($SOInputX, FileReadLine($hFile))
			GUICtrlSetData($SOInputY, FileReadLine($hFile))
			For $r = 0 To 15
				For $s = 0 To 79
					$CoordDataX[$r][$s] = FileReadLine($hFile)
					$CoordDataY[$r][$s] = FileReadLine($hFile)
					$ScanData[$r][$s] = FileReadLine($hFile)
					GUICtrlSetBkColor($Data[$r][$s], $ScanData[$r][$s])
				Next
			Next
		EndIf
		FileClose($hFile)
	EndIf
	rdyBeep()
EndFunc   ;==>LoadData

Func IsSubtract()
	$Plus = Not $Plus
	ClickBeep()
EndFunc   ;==>IsSubtract

Func ProfilSwitch()
	If $Lock = False Then
		$Lock = Not $Lock
		$ProfilSwitch = Not $ProfilSwitch
		If $ProfilSwitch = True Then
			GUICtrlSetState($P1Button, $GUI_UNCHECKED)
			GUICtrlSetState($P2Button, $GUI_CHECKED)
			$MemoryXyXy[0][0] = GUICtrlRead($LXInput)
			$MemoryXyXy[0][1] = GUICtrlRead($LYInput)
			$MemoryXyXy[0][2] = GUICtrlRead($RXInput)
			$MemoryXyXy[0][3] = GUICtrlRead($RYInput)
			GUICtrlSetData($LXInput, $MemoryXyXy[1][0])
			GUICtrlSetData($LYInput, $MemoryXyXy[1][1])
			GUICtrlSetData($RXInput, $MemoryXyXy[1][2])
			GUICtrlSetData($RYInput, $MemoryXyXy[1][3])
		Else
			GUICtrlSetState($P1Button, $GUI_CHECKED)
			GUICtrlSetState($P2Button, $GUI_UNCHECKED)
			$MemoryXyXy[1][0] = GUICtrlRead($LXInput)
			$MemoryXyXy[1][1] = GUICtrlRead($LYInput)
			$MemoryXyXy[1][2] = GUICtrlRead($RXInput)
			$MemoryXyXy[1][3] = GUICtrlRead($RYInput)
			GUICtrlSetData($LXInput, $MemoryXyXy[0][0])
			GUICtrlSetData($LYInput, $MemoryXyXy[0][1])
			GUICtrlSetData($RXInput, $MemoryXyXy[0][2])
			GUICtrlSetData($RYInput, $MemoryXyXy[0][3])
		EndIf
		ClickBeep()
		Sleep(200)
		$Lock = Not $Lock
	EndIf
EndFunc   ;==>ProfilSwitch

Func ClickBeep()
	Beep(500, 35)
	Sleep(60)
EndFunc   ;==>ClickBeep

Func rdyBeep()
	For $i = 0 To 1
		Beep(5000, 100)
		Sleep(100)
	Next
EndFunc   ;==>rdyBeep

Func HelpTxT()
	ShellExecute(@ScriptDir & "\help.txt")
	ClickBeep()
EndFunc   ;==>HelpTxT

Func Terminate()
	_Resource_DestroyAll()
	DllClose($hDLL)
	Exit 0
EndFunc   ;==>Terminate
