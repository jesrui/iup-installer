; -- iup.iss --

#define AppVersion "3.32"

[Setup]
AppName=Iup MinGW6
AppVersion={#AppVersion}
WizardStyle=modern
DefaultDirName={autopf}\iup-mingw6
DefaultGroupName=Iup
;UninstallDisplayIcon={app}\MyProg.exe
Compression=lzma2
SolidCompression=yes
OutputBaseFilename=IupSetup-MinGW6-{#AppVersion}

; "ArchitecturesAllowed=x64" specifies that Setup cannot run on
; anything but x64.
ArchitecturesAllowed=x64
; "ArchitecturesInstallIn64BitMode=x64" requests that the install be
; done in "64-bit mode" on x64, meaning it should use the native
; 64-bit Program Files directory and the 64-bit view of the registry.
ArchitecturesInstallIn64BitMode=x64


[Files]
Source: "build\mingw6\iup-build\*"; DestDir: "{app}"; Flags:  recursesubdirs

[Icons]
Name: "{group}\Iup Lua"; Filename: "{app}\bin\iup\Lua54\iuplua54.exe"
Name: "{group}\Iup Lua Scripter"; Filename: "{app}\bin\iup\Lua54\iupluascripter54.exe"
Name: "{group}\Iup Test"; Filename: "{app}\bin\iup\iuptest.exe"
Name: "{group}\Iup Help"; Filename: "{app}\doc\iup\iup-3.32.chm"
Name: "{group}\Iup Tutorial"; Filename: "{app}\doc\iup\html\examples\tutorial"

[Tasks]
Name: LuaFileAssociation; Description: "Associate ""lua"" files with Iup Lua Scripter"
Name: StartAfterInstall; Description: "Launch Iup Lua Scripter with example file after install"

[Run]
Filename: "{app}\bin\iup\Lua54\iupluascripter54.exe"; Parameters: """{app}\doc\iup\html\examples\tutorial\example2_1.lua"""; Tasks: StartAfterInstall; Flags: nowait postinstall skipifsilent

; https://jrsoftware.org/isfaq.php#assoc
[Registry]
Root: HKA; Subkey: "Software\Classes\.lua\OpenWithProgids"; ValueType: string; ValueName: "IupLuaScripterFile.lua"; ValueData: ""; Flags: uninsdeletevalue; Tasks: LuaFileAssociation
Root: HKA; Subkey: "Software\Classes\IupLuaScripterFile.lua"; ValueType: string; ValueName: ""; ValueData: "Lua script"; Flags: uninsdeletekey; Tasks: LuaFileAssociation
Root: HKA; Subkey: "Software\Classes\IupLuaScripterFile.lua\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\bin\iup\Lua54\iupluascripter54.exe,0"; Tasks: LuaFileAssociation
Root: HKA; Subkey: "Software\Classes\IupLuaScripterFile.lua\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\bin\iup\Lua54\iupluascripter54.exe"" ""%1"""; Tasks: LuaFileAssociation
Root: HKA; Subkey: "Software\Classes\Applications\iupluascripter54.exe\SupportedTypes"; ValueType: string; ValueName: ".lua"; ValueData: ""; Tasks: LuaFileAssociation
