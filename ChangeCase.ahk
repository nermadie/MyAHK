#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")  ; Faster and more reliable
SetWorkingDir(A_ScriptDir)  ; Consistent starting directory

^!.:: {  ; Convert text to UPPERCASE
    OldClipboard := A_Clipboard
    A_Clipboard := ""
    Send("^c")
    if ClipWait(1) {
        A_Clipboard := StrUpper(A_Clipboard)
        Send(A_Clipboard)
    }
    Sleep(1000)
    A_Clipboard := OldClipboard
}

^!,:: {  ; Convert text to lowercase
    OldClipboard := A_Clipboard
    A_Clipboard := ""
    Send("^c")
    if ClipWait(1) {
        A_Clipboard := StrLower(A_Clipboard)
        Send(A_Clipboard)
    }
    Sleep(1000)
    A_Clipboard := OldClipboard
}

^!/:: {  ; Convert text to Capitalized (Title Case)
    OldClipboard := A_Clipboard
    A_Clipboard := ""
    Send("^c")
    if ClipWait(1) {
        A_Clipboard := StrTitle(A_Clipboard)
        Send(A_Clipboard)
    }
    Sleep(1000)
    A_Clipboard := OldClipboard
}
