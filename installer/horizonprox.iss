; HorizonProx — Inno Setup installer script
; Build the Flutter release first:
;   dart run build_runner build --delete-conflicting-outputs
;   flutter build windows --release
; Then compile this script:
;   "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" installer\horizonprox.iss

#define AppName      "HorizonProx"
#define AppVersion   "1.0.0"
#define AppPublisher "HorizonProx"
#define AppExeName   "fzprox.exe"
#define BuildDir     "..\build\windows\x64\runner\Release"

[Setup]
AppId={{A3F2C1D4-87BE-4E5A-9F3C-2D1B0E6A8F4C}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL=https://github.com
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
AllowNoIcons=yes
; Output
OutputDir=output
OutputBaseFilename=HorizonProx-{#AppVersion}-Setup
; Compression
Compression=lzma2/ultra64
SolidCompression=yes
; UI
WizardStyle=modern
WizardResizable=yes
; Architecture — x64 only (Flutter Windows requirement)
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
; Minimum Windows version: Windows 10
MinVersion=10.0.17763
; No signing — SmartScreen will warn on first run; users click More info → Run anyway
; SignTool=...

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; \
  Description: "{cm:CreateDesktopIcon}"; \
  GroupDescription: "{cm:AdditionalIcons}"; \
  Flags: unchecked

[Files]
; All Flutter build output (exe + DLLs + data/)
Source: "{#BuildDir}\*"; \
  DestDir: "{app}"; \
  Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#AppName}";                  Filename: "{app}\{#AppExeName}"
Name: "{group}\Uninstall {#AppName}";        Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}";            Filename: "{app}\{#AppExeName}"; \
  Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExeName}"; \
  Description: "{cm:LaunchProgram,{#AppName}}"; \
  Flags: nowait postinstall skipifsilent

[UninstallDelete]
; Remove any files created by the app at runtime
Type: filesandordirs; Name: "{userappdata}\{#AppName}"
