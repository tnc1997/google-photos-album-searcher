#define MyAppName "Album Searcher for Google Photos"
#define MyAppVersion "1.0.5"
#define MyAppPublisher "Thomas Clark"
#define MyAppURL "https://googlephotosalbumsearcher.thomasclark.app"
#define MyAppExeName "google_photos_album_searcher.exe"

[Setup]
AppId={{9DD0AF3C-5FAF-42D5-BDD3-66CFE6C4BC99}
AppName={#MyAppName}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppVersion={#MyAppVersion}
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
DefaultDirName={autopf}\{#MyAppName}
LicenseFile=LICENSE
PrivilegesRequiredOverridesAllowed=dialog
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: createallsubdirs ignoreversion recursesubdirs

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{tmp}\vc_redist.exe"; Parameters: "/install /passive /norestart"; Check: VCRedistNeedsInstall
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
var
  DownloadPage: TDownloadWizardPage;
procedure InitializeWizard;
begin
  DownloadPage := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), nil);
end;
function NextButtonClick(CurPageID: Integer): Boolean;
begin
  if CurPageID = wpReady then
  begin
    DownloadPage.Clear;
    DownloadPage.Add('https://aka.ms/vs/17/release/vc_redist.x64.exe', 'vc_redist.exe', '');
    DownloadPage.Show;
    try
      try
        DownloadPage.Download;
        Result := True;
      except
        if not DownloadPage.AbortedByUser then
          SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
        Result := False;
      end;
    finally
      DownloadPage.Hide;
    end;
  end else
    Result := True;
end;
function VCRedistNeedsInstall: Boolean;
var
  Major: Cardinal;
begin
  Result := True;
  if RegQueryDWordValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64', 'Major', Major) then
    Result := (Major < 14);
end;
