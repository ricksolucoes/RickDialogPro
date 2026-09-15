program RickDialogPro.Source;

uses
  System.StartUpCopy,
  FMX.Forms,
  RickDialogPro.Source.Page.Main in 'view\RickDialogPro.Source.Page.Main.pas' {PageMain},
  RickDialogPro.Source.Theme.Green.Colors in 'theme\RickDialogPro.Source.Theme.Green.Colors.pas',
  RickDialogPro.Source.Theme.Green in 'theme\RickDialogPro.Source.Theme.Green.pas',
  RickDialogPro.Source.Theme.Light.Colors in 'theme\RickDialogPro.Source.Theme.Light.Colors.pas',
  RickDialogPro.Source.Theme.Light in 'theme\RickDialogPro.Source.Theme.Light.pas';

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Initialize;
  Application.CreateForm(TPageMain, PageMain);
  Application.Run;
end.
