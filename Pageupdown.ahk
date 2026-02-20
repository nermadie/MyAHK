#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe Code.exe") || WinActive("ahk_exe eclipse.exe")
!d:: Send("5j")
!u:: Send("5k")
#HotIf