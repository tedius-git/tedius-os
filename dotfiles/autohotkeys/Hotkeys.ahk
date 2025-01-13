#Requires AutoHotkey v2.0

; Invertir Caps Lock y Esc
CapsLock::Esc
Esc::CapsLock

; Abrir terminal con Windows + Enter
#Enter::
{
    Run "C:\Program Files\WezTerm\wezterm-gui.exe"
}

#,::
{
    ; Abre la configuración de Windows
    Run "ms-settings:"
    return
}

#n::
{
    Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Zen Browser.lnk"
}

#o::
{
    Run "C:\Program Files\WindowsApps\44576milosp.OneCommander_3.87.2.0_neutral__p0rg76fmnrgsm\Rapidrive\OneCommander.exe"
}

#f::WinMaximize "A"  ; Maximizar ventana actual
#+f::WinRestore "A"  ; Restaurar ventana actual

#q::WinClose "A"

#c::
{
    A_Clipboard := ""  ; Limpia el portapapeles
    Send "^c"  ; Simula Ctrl+C para copiar el texto seleccionado
    if ClipWait(2)  ; Espera hasta 2 segundos para que el texto esté disponible
    {
        Run "https://www.google.com/search?q=" . UrlEncode(A_Clipboard)
    }
    else
    {
        MsgBox "No se pudo copiar el texto seleccionado."
    }
}

#t::
{
    A_Clipboard := ""  ; Limpia el portapapeles
    Send "^c"  ; Simula Ctrl+C para copiar el texto seleccionado
    if ClipWait(2)  ; Espera hasta 2 segundos para que el texto esté disponible
    {
        Run "https://translate.google.com/?sl=auto&tl=es&text=" . UrlEncode(A_Clipboard)
    }
    else
    {
        MsgBox "No se pudo copiar el texto seleccionado."
    }
}

UrlEncode(str) {
    return StrReplace(StrReplace(StrReplace(StrReplace(StrReplace(str, 
        "%", "%25"), "&", "%26"), "=", "%3D"), "+", "%2B"), " ", "+")
}
