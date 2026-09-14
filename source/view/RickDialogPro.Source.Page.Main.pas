unit RickDialogPro.Source.Page.Main;

interface

uses
  Rick.Dialog.Pro,

  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.SysUtils,

  FMX.Types,
  FMX.Forms,
  FMX.Dialogs,
  FMX.ListBox,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Graphics,
  FMX.Controls,
  FMX.Controls.Presentation;

type
  TPageMain = class(TForm)
    btError: TSpeedButton;
    btWarning: TSpeedButton;
    lblTitle: TLabel;
    lnTitle: TLine;
    btInformation: TSpeedButton;
    btSuccess: TSpeedButton;
    lblThemas: TLabel;
    cbxThemas: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btErrorClick(Sender: TObject);
    procedure btWarningClick(Sender: TObject);
    procedure btInformationClick(Sender: TObject);
    procedure btSuccessClick(Sender: TObject);
  private
    FDialog : IRickDialogPro;
  end;

var
  PageMain: TPageMain;

implementation

{$R *.fmx}

procedure TPageMain.btErrorClick(Sender: TObject);
begin
  FDialog.Error('Error', 'Mensagem de Erro');
end;

procedure TPageMain.btInformationClick(Sender: TObject);
begin
  FDialog.Information('Information', 'Mensagem de Information');
end;

procedure TPageMain.btSuccessClick(Sender: TObject);
begin
  FDialog.Success('Success', 'Mensagem de Success');
end;

procedure TPageMain.btWarningClick(Sender: TObject);
begin
  FDialog.Warning('Warning', 'Mensagem de Warning');
end;

procedure TPageMain.FormCreate(Sender: TObject);
begin
  FDialog := TRickDialogPro.New;
end;

procedure TPageMain.FormDestroy(Sender: TObject);
begin
  FDialog := Nil;
end;

end.
