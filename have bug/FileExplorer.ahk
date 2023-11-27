;
; This code is an adaptation of QuickLinks.ahk, by Jack Dunning.
; http://www.computoredge.com/AutoHotkey/AutoHotkey_Quicklinks_Menu_App.html
; Update 2019-10-24:
;- Added name of menu as variable 
;- Changed functions to V2 compatible
;- Submenu's with the same name are allowed now

#NoEnv
#SingleInstance, Force

QL_CreateMenu()

#z::
  QL_Show()
return

QL_CreateMenu(QL_Link_Dir := "Links") { ; Just run it one time at the start.
  If !InStr(QL_Link_Dir, "\"){
    QL_Link_Dir := A_ScriptDir "\" QL_Link_Dir 
  }

  SplitPath, QL_Link_Dir,QL_Menu

  If !FileExist(QL_Link_Dir){
    FileCreateDir, %QL_Link_Dir%
  }
  FileCreateShortcut, %QL_Link_Dir%, %QL_Link_Dir%\%QL_Menu%.lnk

  Loop, %QL_Link_Dir%\*.*, 1 , 1
  {	
    if InStr(A_LoopFileAttrib, "H") or InStr(A_LoopFileAttrib, "R"), or InStr(A_LoopFileAttrib, "S") ;Skip any file that is H, R, or S (System).
      continue

    Folder1 := RegExReplace(A_Loopfilefullpath, "(.*\\[^\\]*)\\([^\\]*)\\([^\\]*)", "$2")
    Folder1Menu := QL_Menu StrReplace(StrReplace(RegExReplace(A_Loopfilefullpath, "(.*\\[^\\]*\\[^\\]*)\\([^\\]*)", "$1"), QL_Link_Dir), "\")
    Folder2Menu := QL_Menu StrReplace(StrReplace(RegExReplace(A_Loopfilefullpath, "(.*\\[^\\]*)\\([^\\]*)\\([^\\]*)", "$1"), QL_Link_Dir), "\")

    BoundRun := Func("Run").Bind(A_Loopfilefullpath)
    Linkname := StrReplace(A_LoopFileName, ".lnk")

    Menu, %Folder1Menu%, Add, %Linkname% , %BoundRun%
    Icon_Add(Folder1Menu,Linkname,A_LoopFileFullPath) ; icon
    Menu , %Folder2Menu%, Add, %Folder1%, :%Folder1Menu% ; Create submenu
    Menu , %Folder2Menu% , Icon , %Folder1% , C:\Windows\syswow64\SHELL32.dll , 5 ; icon for folder
  }
return
}

QL_Show(Link_Name:= "Links") {
  Menu, %Link_Name%, Show
}

Run( a) {
  run, %a%
}

Icon_Add(menuitem,submenu,LoopFileFullPath){ ; add icon based on extention or name
  If InStr(LoopFileFullPath, ".lnk"){
    FileGetShortcut,%LoopFileFullPath% ,File, , , , OutIcon, OutIconNum
    if (OutIcon!=""){
      Menu, %menuitem%, Icon, %submenu%, %OutIcon%,%OutIconNum%
      return
    }
  }
  Else{
    File := LoopFileFullPath
  }

  RegExReplace(File,"\.", "",Number_Dots) ;counts the dots
  Extension := RegExReplace(File, "([^\.]*)(\.[^\.]*).*", "$2")
  Extension2 := RegExReplace(LoopFileFullPath, "([^\.]*)(\..*)", "$2")
  Icon_nr = 0
  If (Extension = ".exe"){
    Menu, %menuitem%, Icon, %submenu%, %file%,1
    return
  }

  IconFile := StrSplit(getExtIcon(StrReplace(Extension, ".")), ",")

  If InStr(Extension, "\"){
    Menu, %menuitem%, Icon, %submenu%, C:\Windows\syswow64\SHELL32.dll , 5
  }
  Else If (Extension = ".ahk")
    Menu, %menuitem%, Icon, %submenu%, autohotkey.exe,2
  Else If (Extension = ".jpg")
    Menu, %menuitem%, Icon, %submenu%, %A_Windir%\system32\SHELL32.dll, 140,
  Else If (Extension = ".pdf" and FileExist(A_ScriptDir "\Icons\PDF.ico"))
    Menu, %menuitem%, Icon, %submenu%, %A_ScriptDir%\Icons\PDF.ico
  Else If InStr(Extension, ".xls") and FileExist(A_ScriptDir "\Icons\xlicons.exe")
    Menu, %menuitem%, Icon, %submenu%, %A_ScriptDir%\Icons\xlicons.exe, 0
  Else If InStr(Extension, ".doc") and FileExist(A_ScriptDir "\Icons\wordicon.exe")
    Menu, %menuitem%, Icon, %submenu%, %A_ScriptDir%\Icons\wordicon.exe, 0
  Else If InStr(Extension, ".ppt") and FileExist(A_ScriptDir "\Icons\ppticon.exe")
    Menu, %menuitem%, Icon, %submenu%, %A_ScriptDir%\Icons\ppticon.exe, 0
  Else If InStr(A_LoopFileFullPath, ".website") and FileExist(A_ScriptDir "\Icons\ielowutil.exe")
    Menu, %menuitem%, Icon, %submenu%, %A_ScriptDir%\Icons\ielowutil.exe, 0
  Else If (Extension = ".txt")
    Menu, %menuitem%, Icon, %submenu%, C:\Windows\syswow64\Notepad.exe , 0
  Else If (Extension = ".pro")
    Menu, %menuitem%, Icon, %submenu%, C:\Windows\syswow64\Notepad.exe , 0
  Else If (Extension2 = ".url") and InStr(A_LoopFileLongPath,"Windchill") and FileExist(A_ScriptDir "\Icons\Windchill.ico"){
    Menu, %menuitem%, Icon, %submenu%, %A_ScriptDir%\Icons\Windchill.ico	
  }
  Else If (IconFile[1]!=""){
    Menu, %menuitem%, Icon, %submenu%, % IconFile[1] , % IconFile[2] 
    return
  }
  ; Find hidden icons in the following directory: C:\Windows\Installer
Return
}

getExtIcon(Ext) {
  I1 := I2:= ""
  RegRead, from, HKEY_CLASSES_ROOT, .%Ext%
  RegRead, DefaultIcon, HKEY_CLASSES_ROOT, %from%\DefaultIcon
  StringReplace, DefaultIcon, DefaultIcon, `",,all
  StringReplace, DefaultIcon, DefaultIcon, `%SystemRoot`%, %A_WinDir%,all
  StringReplace, DefaultIcon, DefaultIcon, `%ProgramFiles`%, %A_ProgramFiles%,all
  StringReplace, DefaultIcon, DefaultIcon, `%windir`%, %A_WinDir%,all
  StringSplit, I, DefaultIcon, `,
Return I1 "," IndexOfIconResource( I1, RegExReplace(I2, "[^\d]+") )
}

IndexOfIconResource(Filename, ID){
  hmod := DllCall("GetModuleHandle", "str", Filename, "PTR")
  ; If the DLL isn't already loaded, load it as a data file.
  loaded := !hmod
  && hmod := DllCall("LoadLibraryEx", "str", Filename, "PTR", 0, "uint", 0x2)

  enumproc := RegisterCallback("IndexOfIconResource_EnumIconResources","F")
  VarSetCapacity(param,12,0)
  NumPut(ID,param,0)
  ; Enumerate the icon group resources. (RT_GROUP_ICON=14)
  DllCall("EnumResourceNames", "uint", hmod, "uint", 14, "uint", enumproc, "PTR", &param)
  DllCall("GlobalFree", "PTR", enumproc)

  ; If we loaded the DLL, free it now.
  if loaded
    DllCall("FreeLibrary", "PTR", hmod)

return NumGet(param,8) ? NumGet(param,4) : 0
}

ResourceIdOfIcon_EnumIconResources(hModule, lpszType, lpszName, lParam){
  index := NumGet(lParam+4)
  if (index = NumGet(lParam+0))
  { ; for named resources, lpszName might not be valid once we return (?)
    ; if (lpszName >> 16 == 0), lpszName is an integer resource ID.
    NumPut(lpszName, lParam+4)
    NumPut(1, lParam+8)
    return false ; break
  }
  NumPut(index+1, lParam+4)
return true
}