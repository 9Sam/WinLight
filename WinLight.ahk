#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include libraries/JSON.ahk

I_Icon = S:\SAM\Programación\Autohotkey\scripts\bots\WinLight\images\idea.png

IfExist, %I_Icon%
    Menu, Tray, Icon, %I_Icon%

global cont := 0
global cont2 := 0
global wordList
global coincidencias := 0

FileRead jsonString, commands.json

Data := JSON.Load(jsonString)
global commands := Data.commands


!Space::

1:

	Gui,1: Destroy
	Gui,1: +AlwaysOnTop
    WinSet, TransColor, EEAA99
    Gui,1:Font, s10 cblack, Segoe UI
    Gui, Color, 2A2A25
	Gui,1: Add, Picture, x0 y0 w300 h200, S:\SAM\Programación\Autohotkey\scripts\bots\WinLight\images\background1.jpg
	Gui,1: Add, Edit, x10 y40 w280 h20 -WantReturn vSearch gEdit1,
	; Gui,1: Add, ListBox, WantReturn x10 y50 w100 h50 vWords gSelected,
	Gui,1: Add, Text, cblack x10 y10 +Center +BackgroundTrans, 💡 What would you like to do?
	Gui,1: Add, Button, cred x20 y100 w100 h30 +Default gbtn_aceptar, ✅ Aceptar
	Gui,1: Add, Button, x180 y100 w100 h30 gbtn_salir, ❎ Salir
	Gui,1: Show, w300 h150, WinLight
	return


	#IfWinActive, WinLight
		CapsLock::
            Gui, Destroy
		    Gui, Minimize
        Return

        ::prog::programacion
        ::disc::discord
        ::lib::libros
        ::cla::close all
	return


    ; If (Search = ""){
	; 	GuiControl,Hide,Words
	; 	cont=0
	; 	cont2=0
	; }

    ; if(coincidencias == 1){
    ;     GuiControl,, Words, %listaPalabras%
    ;     conicidencias = 1
	; }

    ; --------------- COMPONENTS ---------------
    btn_aceptar:
		cont=0
		cont2=0
        res=0
		WinHide, WinLight
		gui, submit, nohide

            res := HasVal(commands, Search)

            if(res > 0){
                if(commands[res].commandType = "run") {
                    Run, % commands[res].action
                }
                Else{
                    MsgBox, Nothing to show
                }
            }
        
	return

    HasVal(haystack, needle) {
        if !(IsObject(haystack)) || (haystack.Length() = 0)
            return 0
        for index, value in haystack
            if (value.command = needle or value.alias = needle)
                return index
        return 0
    }

    searchWords(c2,searchedText){
        MsgBox, % searchedText
        for key,value in commands
            commandText := commands[key].command
            extraction := SubStr(commandText,1,c2)
            MsgBox, % extraction

        	if(searchedText==extraction){
				coincidencias = 1
				wordList = %wordList% | %palabra%
			}else{
				GuiControl,hide,Words
			}

        ; Loop ;Loop para buscar las palabras que coinciden
        ; {
		; 	cont++
		; 	; if ErrorLevel
		; 	; break

		; 	extraccion := SubStr(palabra,1,c2)
		; 	if(busqueda==extraccion){
		; 		coincidencias = 1
		; 		listaPalabras = %listaPalabras% | %palabra%
		; 	}else{
		; 		GuiControl,hide,Words
		; 	}
        ; }
	    ; cont = 0
	}

	Edit1:
        ; If (Search = ""){
        ;     GuiControl,Hide,Words
        ;     cont=0
        ;     cont2=0
        ; }
        ;~ MsgBox,%Words% %listaPalabras%
        cont2++
        ; searchWords(count, Search)
        ; MsgBox, % wordList
        GuiControl,, Words, %wordList%
        ; GuiControl,Hide,Words
        Gui, submit, nohide
	return

	Selected:
		len := StrLen(Words)
		Sleep, 10
		len := len - 1
		pal := SubStr(Words,2,len)
		GuiControl,,Search,%pal%
	return

	btn_salir:
		Gui, Destroy
		Gui, Minimize
	return

    Esc::
		Gui, Destroy
		Gui, Minimize
    Return
return