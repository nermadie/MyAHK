#Requires AutoHotkey v2.0

^F2::CheckActiveWindow()

CheckActiveWindow() {
    ID := WinExist("A")
    Class := WinGetClass("ahk_id " ID)
    WClasses := "CabinetWClass ExploreWClass"

    if InStr(WClasses, Class)
        Toggle_HiddenFiles_Display(ID)
}

Toggle_HiddenFiles_Display(ID) {
    RootKey := "HKEY_CURRENT_USER"
    SubKey := "Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

    HiddenFiles_Status := RegRead(RootKey "\" SubKey, "Hidden")

    if HiddenFiles_Status = 2 {
        RegWrite("REG_DWORD", RootKey "\" SubKey, "Hidden", 1)
    } else {
        RegWrite("REG_DWORD", RootKey "\" SubKey, "Hidden", 2)
    }

    PostMessage(0x111, 41504, 0, "", "ahk_id " ID)
}