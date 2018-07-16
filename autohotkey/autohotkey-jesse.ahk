#NoEnv
SendMode Input
SetTitleMatchMode, RegEx

#include includes/mac-like-mappings.ahk

#include includes/logitech-functionless-audio-controls.ahk

#include includes/caps-hjkl-or-esc.ahk

OverrideCapsLock()
{
    If WinActive("Brood War")
        return "."
    If WinActive("Age of Empires")
        return "."
}
