; #If, WinActive("ahk_exe Code.exe") or WinActive("ahk_exe devenv.exe") or WinActive("ahk_exe eclipse.exe") or WinActive("ahk_exe idea64.exe") or WinActive("ahk_exe pycharm64.exe") or WinActive("ahk_exe phpstorm64.exe") or WinActive("ahk_exe nvim-qt.exe") or WinActive("ahk_exe WindowsTerminal.exe")
#If, 1==1
  CapsLock::Esc
Esc::
  if (GetKeyState("CapsLock", "T")) {
    SetCapsLockState, Off
  } else {
    SetCapsLockState, On
  }
return