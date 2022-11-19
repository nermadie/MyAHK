#If, WinActive("ahk_exe Code.exe") or WinActive("ahk_exe devenv.exe")
Del::
  if (GetKeyState("CapsLock", "T")) {
    SetCapsLockState, Off
  } else {
    SetCapsLockState, On
  }
return
