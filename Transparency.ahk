#Requires AutoHotkey v2.0

^!t::
{
    ; Tạo menu với các mức độ trong suốt
    menu := MenuCreate()
    for transparency in [255, 250, 245, 240, 235, 230, 225, 220, 210, 200, 190, 180, 170, 160, 150, 140, 100] {
        menu.Add(transparency, (menuItem) => SetTrans(menuItem))
    }
    menu.Show() ; Hiển thị menu
}
return

SetTrans(menuItem) {
    Sleep(100) ; Tạm dừng trong 100 mili giây
    WinSetTransparent(WinExist("A"), menuItem) ; Thiết lập độ trong suốt của cửa sổ hiện tại
}