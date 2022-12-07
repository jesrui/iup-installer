; -- iup.iss --

#define AppVersion "3.30"

[Setup]
AppName=Iup DevKit
AppVersion={#AppVersion}
WizardStyle=modern
DefaultDirName={autopf}\iup
DefaultGroupName=Iup
;UninstallDisplayIcon={app}\MyProg.exe
Compression=lzma2
SolidCompression=yes
OutputBaseFilename=IupSetup-{#AppVersion}

; "ArchitecturesAllowed=x64" specifies that Setup cannot run on
; anything but x64.
ArchitecturesAllowed=x64
; "ArchitecturesInstallIn64BitMode=x64" requests that the install be
; done in "64-bit mode" on x64, meaning it should use the native
; 64-bit Program Files directory and the 64-bit view of the registry.
ArchitecturesInstallIn64BitMode=x64


[Files]
Source: "iup-build\*"; DestDir: "{app}"; Flags:  recursesubdirs
;Source: "C:\iup-build\iup\bin\*"; DestDir: "{app}\bin"; Flags:  recursesubdirs
;Source: "C:\iup-build\iup\doc\*"; DestDir: "{app}\doc"; Flags:  recursesubdirs

[Icons]
Name: "{group}\Iup Lua"; Filename: "{app}\bin\iup\Lua54\iuplua54.exe"
Name: "{group}\Iup Lua Scripter"; Filename: "{app}\bin\iup\Lua54\iupluascripter54.exe"
Name: "{group}\Iup Test"; Filename: "{app}\bin\iup\iuptest.exe"
Name: "{group}\Iup Help"; Filename: "{app}\doc\iup\iup-3.30_Docs.chm"
Name: "{group}\Iup Tutorial"; Filename: "{app}\doc\iup\html\examples\tutorial"

[Tasks]
Name: StartAfterInstall; Description: "Launch Iup Lua Scripter with example file after install"

[Run]
Filename: "{app}\bin\iup\Lua54\iupluascripter54.exe"; Parameters: "{app}\doc\iup\html\examples\tutorial\example2_1.lua"; Tasks: StartAfterInstall; Flags: nowait postinstall skipifsilent
