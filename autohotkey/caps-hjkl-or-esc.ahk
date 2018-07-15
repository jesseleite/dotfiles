#NoEnv
SendMode Input

; Disable default CapsLock functionality
SetCapsLockState, AlwaysOff

; Post Esc if pressed alone
~CapsLock::
    KeyWait, CapsLock
    If (A_PriorKey="CapsLock")
        Send {Esc}
return

; Map CapsLock modified hotkeys
#If, GetKeyState("CapsLock", "P")
h::Left
j::Down
k::Up
l::Right
