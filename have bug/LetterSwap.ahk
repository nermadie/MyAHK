/*
AutoHotkey V1.1
This letter swap routine works by placing the cursor between two characters and 
hitting the Hotkey combination ALT+R. The letters reverse position.
You can find a discussion of this routine (plus other word swapping routines)
in "Chapter Nine: AutoHotkey Windows Clipboard Techniques for Swapping Letters"
in the section  "Eliminating the Requirement for Pre-Selected Text"
of the book "AutoHotkey Hotkeys: Tips, Tricks, Techniques, and Best Practices"
https://www.computoredgebooks.com/AutoHotkey-Hotkey-Techniques-All-File-Formats_c41.htm?sourceCode=FreeAppsPage
*/

$!r:: 
  OldClipboard := ClipboardAll
  Clipboard = ;clears the Clipboard
  SendInput {Left}+{Right 2}
  SendInput, ^c
  ClipWait 0 ;pause for Clipboard data
  If ErrorLevel
  {
    MsgBox, No text selected!
  }
  SwappedLetters := SubStr(Clipboard,2) . SubStr(Clipboard,1,1)
  SendInput, %SwappedLetters%
  SendInput {Left}
  Clipboard := OldClipboard
Return