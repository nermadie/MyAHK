^!c::
  clipback := ClipboardAll
  Clipboard := ""
  Send ^c
  ClipWait, 0
  if !ErrorLevel {
    res := GetCorrectedResultFromYahoo(Clipboard)
    if (res = "") {
      ToolTip No corrected result
      SetTimer, ToolTipDel, -1000
    }
    else {
      Clipboard := res
      Send ^v
    }
  }
  Clipboard := clipback
Return

ToolTipDel() {
  Tooltip
}

GetCorrectedResultFromYahoo(query) {
  url := "https://search.yahoo.com/search?p=" . query
  whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
  whr.Open("GET", url, false)
  whr.Send()
  status := whr.status
  if (status != 200)
    throw Exception("Status: " status)
  res := whr.responseText
  RegExMatch(res, "is)Including results for.+?""unsafe-url"".*?>\K[^\s<][^<]+", match)
Return match
}