#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe Code.exe")
       || WinActive("ahk_exe devenv.exe")
       || WinActive("ahk_exe eclipse.exe")
       || WinActive("ahk_exe idea64.exe")
       || WinActive("ahk_exe pycharm64.exe")
       || WinActive("ahk_exe phpstorm64.exe")
       || WinActive("ahk_exe nvim-qt.exe")
       || WinActive("ahk_exe WindowsTerminal.exe")
^y::Send("{Esc}{Esc}ggyG")
#HotIf