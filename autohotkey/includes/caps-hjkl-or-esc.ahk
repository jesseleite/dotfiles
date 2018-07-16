#NoEnv
SendMode Input

; Disable default CapsLock functionality
SetCapsLockState, AlwaysOff

; Post Esc if pressed alone
CapsLock::

    ; If you want to override CapsLock functionality for specific windows, etc.
    ; Just define an OverrideCapsLock() function where you #include this script!
    OverrideFunction := "OverrideCapsLock"
    
    if (Overridden := %OverrideFunction%()) {
        Send {%Overridden%}
        return
    }
    
    KeyWait, CapsLock
    if (A_PriorKey="CapsLock")
        Send {Esc}
return

; Map CapsLock modified hjkl movement
#If, GetKeyState("CapsLock", "P")
h::Left
j::Down
k::Up
l::Right
#If