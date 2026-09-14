program RickDialogPro.Source;

uses
  System.StartUpCopy,
  FMX.Forms,
  RickDialogPro.Source.Page.Main in 'view\RickDialogPro.Source.Page.Main.pas' {PageMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPageMain, PageMain);
  Application.Run;
end.
