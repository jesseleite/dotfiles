#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Disable default CapsLock functionality
SetCapsLockState, AlwaysOff

; Post Insert if pressed alone
CapsLock::
    KeyWait, CapsLock
    If (A_PriorKey="CapsLock")
        Send {Insert}
return

; Map CapsLock modified hotkeys
#If, GetKeyState("CapsLock", "P")
h::Left
j::Down
k::Up
l::Right
