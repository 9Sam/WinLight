#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include ./libraries/JSON.ahk

I_Icon = images\idea.png

IfExist, %I_Icon%
    Menu, Tray, Icon, %I_Icon%

FileRead jsonSettings, ./config/settings.json
FileRead jsonCommands, ./commands/commands.json
FileRead themesString, ./themes/themes.json
settingsData := JSON.load(jsonSettings)
commandsData := JSON.load(jsonCommands)
themesData := JSON.load(themesString)

;--------------- PARSING ---------------
parsed_out := settings

global cont := 0
global cont2 := 0
global wordList
global coincidencias := 0

global commands := commandsData.commands
global themes := themesData
global settings := settingsData

;-------------------CONFIGS--------------------
global actualTheme := settings.actualTheme

;----------------------------------------------

!Space::
    GText := themes[actualTheme].text
    GFontSize := themes[actualTheme].textSize
    GFontColor := themes[actualTheme].textColor
    GInputColor := themes[actualTheme].inputColor
    GBackground := themes[actualTheme].background

	Gui,1: Destroy
	Gui,1: +AlwaysOnTop
    WinSet, TransColor, EEAA99
    Gui,1:Font, s%GFontSize% c%GInputColor%, Segoe UI
    Gui, Color, 2A2A25
	Gui,1: Add, Picture, x0 y0 w300 h200, %GBackground%
	Gui,1: Add, Edit, x10 y40 w280 h20 -WantReturn vSearch gEdit1,
	Gui,1: Add, ListBox, WantReturn Hidden x10 y60 w280 h50 vWords gSelected,
	Gui,1: Add, Text, c%GFontColor% x10 y10 +Center +BackgroundTrans, 💡 %GText%
	Gui,1: Add, Button, x40 y110 w100 h30 +Default gbtn_aceptar, ✅ Okay
	Gui,1: Add, Button, x160 y110 w100 h30 gbtn_salir, ❎ Exit
	Gui,1: Show, w300 h150, WinLight
	return


	#IfWinActive, WinLight
		CapsLock::
            Gui, Destroy
		    Gui, Minimize
        Return
	return

    Edit1:
    ; MsgBox, % Search
        Gui, submit, nohide
        wordList = 

        if (Search = "") { 
            GuiControl,Hide,Words
            cont=0
            cont2=0
        } else {
            ;~ MsgBox,%Words% %listaPalabras%
            cont2++
            ; GuiControl,Hide,Words
            searchWords(cont2, Search)
            ; MsgBox, % wordList
            if(cont > 0){
                GuiControl,, Words, %wordList%
                GuiControl,Show,Words
                ; MsgBox, % cont
            } else {
                GuiControl,Hide,Words
            }
        }
    return

    ; --------------- COMPONENTS ---------------
    btn_aceptar:
		cont=0
		cont2=0
        res=0
		WinHide, WinLight
		gui, submit, nohide

        prefix := SubStr(Search, 1, 1)
        ; MsgBox, % prefix

        if (prefix == "?") {
            Run, % "https://www.google.com/search?q="SubStr(Search, 2, StrLen(Search))
        } if(prefix == "*"){
            reloadScript()
        } if(prefix == "."){
            if (SubStr(Search, 2, 1) == "s"){
                SoundSet, % SubStr(Search, 3, 4)
            } else if(SubStr(Search, 2, 4) == "mute"){
                SoundSet, 0
            }
        } else {
            res := HasVal(commands, Search)

            if(res > 0){
                if(commands[res].commandType == "run") {
                    Run, % commands[res].action
                }
                Else{
                    MsgBox, Nothing to show
                }
            }
        }
	return

    HasVal(haystack, needle) {
        if !(IsObject(haystack)) || (haystack.Length() = 0)
            return 0
        for index, value in haystack
            if (value.command = needle or value.alias = needle and value.alias != "")
                return index
        return 0
    }

    searchWords(c2,searchedText){
        for key, value in commands {
            commandText := commands[key].command
            commandAlias := commands[key].alias
            extraction := SubStr(commandText,1,c2)
            
        	if(searchedText == extraction){
                cont++
                coincidencias = 1
				wordList = %wordList% | %commandText% [ ↘️ %commandAlias% ]
			}else{
				GuiControl,hide,Words
			}
        }
	}

    reloadScript(){
        MsgBox, updated
        Reload
    }

    ; --------------- functions ---------------
    ; changeTheme(){
    ;     actualTheme
    ; }

    ; --------------- app ---------------

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