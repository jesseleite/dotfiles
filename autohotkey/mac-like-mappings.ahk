#NoEnv
SendMode Input
SetTitleMatchMode, RegEx

!Space::Send {Ctrl Down}{Esc}{Ctrl Up}                  ; Windows Search
!f::Send {Ctrl Down}{f}{Ctrl Up}                        ; Search
!s::Send {Ctrl Down}{s}{Ctrl Up}                        ; Save
!a::Send {Ctrl Down}{a}{Ctrl Up}                        ; Select All
!x::Send {Ctrl Down}{x}{Ctrl Up}                        ; Cut
!c::Send {Ctrl Down}{c}{Ctrl Up}                        ; Cut
!v::Send {Ctrl Down}{v}{Ctrl Up}                        ; Paste
!z::Send {Ctrl Down}{z}{Ctrl Up}                        ; Undo
!t::Send {Ctrl Down}{t}{Ctrl Up}                        ; New Tab
!n::Send {Ctrl Down}{n}{Ctrl Up}                        ; New Window
!w::Send {Ctrl Down}{w}{Ctrl Up}                        ; Close Tab
!q::Send {Alt Down}{F4}{Alt Up}                         ; Close Window
!Left::Send {Home}                                      ; Cursor to BOL
!Right::Send {End}                                      ; Cursor to EOL
!BS::Send {LShift down}{Home}{LShift Up}{Del}           ; Delete to BOL

#IfWinActive Google Chrome
!r::Send {Ctrl Down}{r}{Ctrl Up}                        ; Reload
!l::Send {Ctrl Down}{l}{Ctrl Up}                        ; Address Bar
!+t::Send {Ctrl Down}{Shift Down}{t}{Ctrl Up}{Shift Up} ; Open Closed Tab
