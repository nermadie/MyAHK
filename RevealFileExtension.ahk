#Requires AutoHotkey v2.0

^F1::
{
    HiddenFiles_Status := RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "HideFileExt")
    if HiddenFiles_Status = 1 {
        RegWrite("REG_DWORD", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "HideFileExt", 0)
    } else {
        RegWrite("REG_DWORD", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "HideFileExt", 1)
    }
    Send("{F5}")
}
return