program RickDialogPro.Sample;

uses
  System.StartUpCopy,
  FMX.Forms,
  RickDialogPro.Sample.Page.Main in 'view\RickDialogPro.Sample.Page.Main.pas' {PageMain},
  RickDialogPro.Sample.Theme.Green.Colors in 'theme\RickDialogPro.Sample.Theme.Green.Colors.pas',
  RickDialogPro.Sample.Theme.Green in 'theme\RickDialogPro.Sample.Theme.Green.pas',
  RickDialogPro.Sample.Theme.Light.Colors in 'theme\RickDialogPro.Sample.Theme.Light.Colors.pas',
  RickDialogPro.Sample.Theme.Light in 'theme\RickDialogPro.Sample.Theme.Light.pas';

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Initialize;
  Application.CreateForm(TPageMain, PageMain);
  Application.Run;
end.
