#NoEnv
SendMode Input
SetTitleMatchMode, RegEx

SetCapsLockState, AlwaysOff

#IfWinActive Notepad
~CapsLock::f

#IfWinActive Age of Empires II
~CapsLock::Send {Insert}
