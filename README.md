# About this project

The purpose of this project is to simulate the spotlight functionality of mac OS in windows using AutoHotkey to achieve this. The main functionality is to execute commands from an input file, these commands are locally stored in a JSON file and the program will execute the command if this exists.\

# Installation

First of all, you must install AutoHotkey by downloading the exe file from its website [autohotkey.com](https://www.autohotkey.com)

To install this project on your computer just download the containing folder and execute the **WinLight.ahk** file within the folder, alternatively you could make a shortcut file and save it in the start folder of windows so it will be loaded on the next start of the system.

> Open the startup forlder by pressing the `Windows + R` keys on your keyboard.

# Create commands

## Commands file

The `commands.json` contains all of the commands that will be created to access files, folders or websites

## Command structure

**command**: The property is used to declare the word or succession of letters used to represent the command
**alias**: It is used as a richer representation of the command property, it must be considered as a short description of the command property, the length of the **alias** property shouldn't be so long or it could lead to a bad visual representation. Four (4) words max will be fine.

## Create a command to open files

```json
{
    "command": "<commandCharacteres>",
    "alias": "<commandNameRepresentation>",
    "commandType": "run",
    "sound": "false",
    "action": "<fileRoute>",
    "type":"📄 File"
},
```


# Functionalities

## Make google searches in your default browser

To make a search in google from Winlight you must include a `?` character before the text you want to search.

# Included commands

## Sound commands

`.s <number(1-100)>` -> Set sound to any number you want between 1 and 100  
`.mute` -> Set volume to 0


# Personalization

## Themes file

> note: Autohotkey has certain limitations when creating custom style, so there will be only a few things that you will be able to modify, like the text color, image background, font size or the input font color.

The theme file includes the different themes of the application, you can modify the default themes or create a new one.

## Create your custom themes

To create a new theme just copy the structure of one of the current objects in the json file and replace the values with your preffered values.

