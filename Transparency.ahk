^!t::
  ;   WinGet, currentTransparency, Transparent, A
  ;   if (currentTransparency = OFF)
  ;   {
  ;     WinSet, Transparent, 220, A
  ;   }
  ;   else
  ;   {
  ;     WinSet, Transparent, OFF, A
  ;   }
  ; return
  Menu, Transparency, Add, 255, SetTrans
  Menu, Transparency, Add, 240, SetTrans
  Menu, Transparency, Add, 230, SetTrans
  Menu, Transparency, Add, 220, SetTrans
  Menu, Transparency, Add, 210, SetTrans
  Menu, Transparency, Add, 200, SetTrans
  Menu, Transparency, Add, 190, SetTrans
  Menu, Transparency, Add, 180, SetTrans
  Menu, Transparency, Add, 170, SetTrans
  Menu, Transparency, Add, 160, SetTrans
  Menu, Transparency, Add, 150, SetTrans
  Menu, Transparency, Add, 140, SetTrans
  Menu, Transparency, Add, 100, SetTrans
  Menu, Transparency, Show
Return

SetTrans: ; subroutine run by menu item
  Sleep 100 ; delay 100 milliseconds  
  WinSet, Transparent, %A_ThisMenuItem%, A
Return