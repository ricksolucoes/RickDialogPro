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
    btApplyTheme: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btErrorClick(Sender: TObject);
    procedure btWarningClick(Sender: TObject);
    procedure btInformationClick(Sender: TObject);
    procedure btSuccessClick(Sender: TObject);
    procedure btApplyThemeClick(Sender: TObject);
  private
    FDialog : IRickDialogPro;
    procedure LoadThemes;
    procedure ApplySelectedTheme;
  end;

var
  PageMain: TPageMain;

implementation

uses
  RickDialogPro.Source.Theme.Light,
  RickDialogPro.Source.Theme.Green;

{$R *.fmx}

const
  _THEME_DEFAULT = 0;
  _THEME_LIGHT = 1;
  _THEME_GREEN = 2;

procedure TPageMain.ApplySelectedTheme;
begin
  case cbxThemas.ItemIndex of
    _THEME_LIGHT:
      FDialog := TRickDialogPro.New(TRickDialogProSourceLightTheme.New);

    _THEME_GREEN:
      FDialog := TRickDialogPro.New(TRickDialogProSourceGreenTheme.New);
  else
    FDialog := TRickDialogPro.New;
  end;
end;

procedure TPageMain.btApplyThemeClick(Sender: TObject);
begin
  ApplySelectedTheme;
end;

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
  LoadThemes;
  FDialog := TRickDialogPro.New;
end;

procedure TPageMain.FormDestroy(Sender: TObject);
begin
  FDialog := Nil;
end;

procedure TPageMain.LoadThemes;
begin
  cbxThemas.Items.BeginUpdate;
  try
    cbxThemas.Items.Clear;
    cbxThemas.Items.Add('Default');
    cbxThemas.Items.Add('Light');
    cbxThemas.Items.Add('Green');
    cbxThemas.ItemIndex := _THEME_DEFAULT;
  finally
    cbxThemas.Items.EndUpdate;
  end;
end;

end.
