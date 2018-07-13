#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetCapsLockState, AlwaysOff

CapsLock::
    KeyWait, CapsLock
    If (A_PriorKey="CapsLock")
        Send {Insert}
Return
#If, GetKeyState("CapsLock", "P") ;Your CapsLock hotkeys go below

h::Left
j::Down
k::Up
l::Right