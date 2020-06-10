#NoEnv
#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%

Loop Files, %A_ScriptDir%\menu\*.lnk 
{
	MenuString := A_LoopFileName
	word_array := StrSplit(MenuString, ".")
	var:= word_array[1]
	Menu, SeaMenu, Add, %Var%, MenuHandler
}

Loop Files, %A_ScriptDir%\scripts\*.ahk 
{
	MenuString := A_LoopFileName
	word_array := StrSplit(MenuString, ".")
	var:= word_array[1]
	Menu, Scripts, Add, %Var%, ScriptMenuHandler
}

Menu, SeaMenu, Add 
Menu, SeaMenu, Add, Scripts, :Scripts
Menu, System, Add, Control Panel, ControlHandler
Menu, System, Add, Recycle Bin, RecycleHandler
Menu, SeaMenu, Add, System, :System
Menu, Options, Add, Add menu item, AddHandler
Menu, Options, Add, Open Folder, FolderHandler
Menu, Options, Add, Homepage, WebHandler
Menu, SeaMenu, Add, Options, :Options
return 

MenuHandler:
run %A_ScriptDir%\menu\%A_ThisMenuItem%.lnk
return 

ScriptMenuHandler:
run %A_ScriptDir%\scripts\%A_ThisMenuItem%.ahk
return 

AddHandler:
FileSelectFile, SelectedFile, 3 
if (SelectedFile = "")
    MsgBox, The user didn't select anything.
else
    SplitPath, SelectedFile,,,, name_no_ext
    FileCreateShortcut, %SelectedFile%, %A_ScriptDir%\menu\%name_no_ext%.lnk
return 

FolderHandler:
Run %A_ScriptDir%
return 

ControlHandler:
run control panel
return 

RecycleHandler:
run ::{645FF040-5081-101B-9F08-00AA002F954E}
return 

WebHandler:
run  https://github.com/phantomdiorama/seamenu
return 

;--Hotkey--;
#If MouseIsOver("ahk_class Progman") or MouseIsOver("ahk_class WorkerW")
mbutton::
Menu, SeaMenu, show
return 
#If 

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}