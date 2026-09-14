unit Rick.Dialog.Pro.Tests.ThemeSpy;

interface

uses
  System.UITypes,

  Rick.Dialog.Pro.Types,
  Rick.Dialog.Pro.Theme.Interf;

const
  _TEST_THEME_BACKGROUND                        = TAlphaColor($FF010101);
  _TEST_THEME_SURFACE                           = TAlphaColor($FF020202);
  _TEST_THEME_SURFACE_ELEVATED                  = TAlphaColor($FF030303);
  _TEST_THEME_BORDER                            = TAlphaColor($FF040404);
  _TEST_THEME_TEXT_PRIMARY                      = TAlphaColor($FF050505);
  _TEST_THEME_TEXT_SECONDARY                    = TAlphaColor($FF060606);
  _TEST_THEME_STATUS                            = TAlphaColor($FF070707);
  _TEST_THEME_ICON_BACKGROUND                   = TAlphaColor($FF080808);
  _TEST_THEME_ICON_STROKE                       = TAlphaColor($FF090909);
  _TEST_THEME_PRIMARY_BUTTON_BACKGROUND         = TAlphaColor($FF0A0A0A);
  _TEST_THEME_PRIMARY_BUTTON_HOVER_BACKGROUND   = TAlphaColor($FF0B0B0B);
  _TEST_THEME_PRIMARY_BUTTON_TEXT               = TAlphaColor($FF0C0C0C);
  _TEST_THEME_SECONDARY_BUTTON_BACKGROUND       = TAlphaColor($FF0D0D0D);
  _TEST_THEME_SECONDARY_BUTTON_HOVER_BACKGROUND = TAlphaColor($FF0E0E0E);
  _TEST_THEME_SECONDARY_BUTTON_TEXT             = TAlphaColor($FF0F0F0F);

type
  ITestRickDialogProTheme = interface(IRickDialogProTheme)
    ['{D106760C-07DE-48E7-A006-7CFE5FE71572}']

    function GetBackgroundCallCount: Integer;
    function GetSurfaceCallCount: Integer;
    function GetSurfaceElevatedCallCount: Integer;
    function GetBorderCallCount: Integer;
    function GetTextPrimaryCallCount: Integer;
    function GetTextSecondaryCallCount: Integer;

    function GetStatusColorCallCount: Integer;
    function GetIconBackgroundCallCount: Integer;
    function GetIconStrokeCallCount: Integer;

    function GetPrimaryButtonBackgroundCallCount: Integer;
    function GetPrimaryButtonHoverBackgroundCallCount: Integer;
    function GetPrimaryButtonTextCallCount: Integer;

    function GetSecondaryButtonBackgroundCallCount: Integer;
    function GetSecondaryButtonHoverBackgroundCallCount: Integer;
    function GetSecondaryButtonTextCallCount: Integer;

    function GetLastStatusColorKind: TRickDialogProKind;
    function GetLastIconBackgroundKind: TRickDialogProKind;
    function GetLastIconStrokeKind: TRickDialogProKind;

    function GetLastPrimaryButtonBackgroundKind: TRickDialogProKind;
    function GetLastPrimaryButtonHoverBackgroundKind: TRickDialogProKind;
    function GetLastPrimaryButtonTextKind: TRickDialogProKind;
  end;

  TTestRickDialogProTheme = class(TInterfacedObject, ITestRickDialogProTheme)
  protected
    BackgroundCallCount: Integer;
    SurfaceCallCount: Integer;
    SurfaceElevatedCallCount: Integer;
    BorderCallCount: Integer;
    TextPrimaryCallCount: Integer;
    TextSecondaryCallCount: Integer;

    StatusColorCallCount: Integer;
    IconBackgroundCallCount: Integer;
    IconStrokeCallCount: Integer;

    PrimaryButtonBackgroundCallCount: Integer;
    PrimaryButtonHoverBackgroundCallCount: Integer;
    PrimaryButtonTextCallCount: Integer;

    SecondaryButtonBackgroundCallCount: Integer;
    SecondaryButtonHoverBackgroundCallCount: Integer;
    SecondaryButtonTextCallCount: Integer;

    LastStatusColorKind: TRickDialogProKind;
    LastIconBackgroundKind: TRickDialogProKind;
    LastIconStrokeKind: TRickDialogProKind;

    LastPrimaryButtonBackgroundKind: TRickDialogProKind;
    LastPrimaryButtonHoverBackgroundKind: TRickDialogProKind;
    LastPrimaryButtonTextKind: TRickDialogProKind;

    function Background: TAlphaColor;
    function Surface: TAlphaColor;
    function SurfaceElevated: TAlphaColor;
    function Border: TAlphaColor;
    function TextPrimary: TAlphaColor;
    function TextSecondary: TAlphaColor;

    function StatusColor(AKind: TRickDialogProKind): TAlphaColor;
    function IconBackground(AKind: TRickDialogProKind): TAlphaColor;
    function IconStroke(AKind: TRickDialogProKind): TAlphaColor;

    function PrimaryButtonBackground(AKind: TRickDialogProKind): TAlphaColor;
    function PrimaryButtonHoverBackground(
      AKind: TRickDialogProKind): TAlphaColor;
    function PrimaryButtonText(AKind: TRickDialogProKind): TAlphaColor;

    function SecondaryButtonBackground: TAlphaColor;
    function SecondaryButtonHoverBackground: TAlphaColor;
    function SecondaryButtonText: TAlphaColor;

    function GetBackgroundCallCount: Integer;
    function GetSurfaceCallCount: Integer;
    function GetSurfaceElevatedCallCount: Integer;
    function GetBorderCallCount: Integer;
    function GetTextPrimaryCallCount: Integer;
    function GetTextSecondaryCallCount: Integer;

    function GetStatusColorCallCount: Integer;
    function GetIconBackgroundCallCount: Integer;
    function GetIconStrokeCallCount: Integer;

    function GetPrimaryButtonBackgroundCallCount: Integer;
    function GetPrimaryButtonHoverBackgroundCallCount: Integer;
    function GetPrimaryButtonTextCallCount: Integer;

    function GetSecondaryButtonBackgroundCallCount: Integer;
    function GetSecondaryButtonHoverBackgroundCallCount: Integer;
    function GetSecondaryButtonTextCallCount: Integer;

    function GetLastStatusColorKind: TRickDialogProKind;
    function GetLastIconBackgroundKind: TRickDialogProKind;
    function GetLastIconStrokeKind: TRickDialogProKind;

    function GetLastPrimaryButtonBackgroundKind: TRickDialogProKind;
    function GetLastPrimaryButtonHoverBackgroundKind: TRickDialogProKind;
    function GetLastPrimaryButtonTextKind: TRickDialogProKind;
  public
    class function New : ITestRickDialogProTheme; static;
  end;

implementation

function TTestRickDialogProTheme.Background: TAlphaColor;
begin
  Inc(BackgroundCallCount);

  Result := _TEST_THEME_BACKGROUND;
end;

function TTestRickDialogProTheme.Surface: TAlphaColor;
begin
  Inc(SurfaceCallCount);

  Result := _TEST_THEME_SURFACE;
end;

function TTestRickDialogProTheme.SurfaceElevated: TAlphaColor;
begin
  Inc(SurfaceElevatedCallCount);

  Result := _TEST_THEME_SURFACE_ELEVATED;
end;

function TTestRickDialogProTheme.Border: TAlphaColor;
begin
  Inc(BorderCallCount);

  Result := _TEST_THEME_BORDER;
end;

function TTestRickDialogProTheme.TextPrimary: TAlphaColor;
begin
  Inc(TextPrimaryCallCount);

  Result := _TEST_THEME_TEXT_PRIMARY;
end;

function TTestRickDialogProTheme.TextSecondary: TAlphaColor;
begin
  Inc(TextSecondaryCallCount);

  Result := _TEST_THEME_TEXT_SECONDARY;
end;

function TTestRickDialogProTheme.StatusColor(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  Inc(StatusColorCallCount);
  LastStatusColorKind := AKind;

  Result := _TEST_THEME_STATUS;
end;

function TTestRickDialogProTheme.IconBackground(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  Inc(IconBackgroundCallCount);
  LastIconBackgroundKind := AKind;

  Result := _TEST_THEME_ICON_BACKGROUND;
end;

function TTestRickDialogProTheme.IconStroke(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  Inc(IconStrokeCallCount);
  LastIconStrokeKind := AKind;

  Result := _TEST_THEME_ICON_STROKE;
end;

function TTestRickDialogProTheme.PrimaryButtonBackground(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  Inc(PrimaryButtonBackgroundCallCount);
  LastPrimaryButtonBackgroundKind := AKind;

  Result := _TEST_THEME_PRIMARY_BUTTON_BACKGROUND;
end;

function TTestRickDialogProTheme.PrimaryButtonHoverBackground(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  Inc(PrimaryButtonHoverBackgroundCallCount);
  LastPrimaryButtonHoverBackgroundKind := AKind;

  Result := _TEST_THEME_PRIMARY_BUTTON_HOVER_BACKGROUND;
end;

function TTestRickDialogProTheme.PrimaryButtonText(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  Inc(PrimaryButtonTextCallCount);
  LastPrimaryButtonTextKind := AKind;

  Result := _TEST_THEME_PRIMARY_BUTTON_TEXT;
end;

function TTestRickDialogProTheme.SecondaryButtonBackground: TAlphaColor;
begin
  Inc(SecondaryButtonBackgroundCallCount);

  Result := _TEST_THEME_SECONDARY_BUTTON_BACKGROUND;
end;

function TTestRickDialogProTheme.SecondaryButtonHoverBackground: TAlphaColor;
begin
  Inc(SecondaryButtonHoverBackgroundCallCount);

  Result := _TEST_THEME_SECONDARY_BUTTON_HOVER_BACKGROUND;
end;

function TTestRickDialogProTheme.SecondaryButtonText: TAlphaColor;
begin
  Inc(SecondaryButtonTextCallCount);

  Result := _TEST_THEME_SECONDARY_BUTTON_TEXT;
end;

function TTestRickDialogProTheme.GetBackgroundCallCount: Integer;
begin
  Result := BackgroundCallCount;
end;

function TTestRickDialogProTheme.GetSurfaceCallCount: Integer;
begin
  Result := SurfaceCallCount;
end;

function TTestRickDialogProTheme.GetSurfaceElevatedCallCount: Integer;
begin
  Result := SurfaceElevatedCallCount;
end;

function TTestRickDialogProTheme.GetBorderCallCount: Integer;
begin
  Result := BorderCallCount;
end;

function TTestRickDialogProTheme.GetTextPrimaryCallCount: Integer;
begin
  Result := TextPrimaryCallCount;
end;

function TTestRickDialogProTheme.GetTextSecondaryCallCount: Integer;
begin
  Result := TextSecondaryCallCount;
end;

function TTestRickDialogProTheme.GetStatusColorCallCount: Integer;
begin
  Result := StatusColorCallCount;
end;

function TTestRickDialogProTheme.GetIconBackgroundCallCount: Integer;
begin
  Result := IconBackgroundCallCount;
end;

function TTestRickDialogProTheme.GetIconStrokeCallCount: Integer;
begin
  Result := IconStrokeCallCount;
end;

function TTestRickDialogProTheme.GetPrimaryButtonBackgroundCallCount: Integer;
begin
  Result := PrimaryButtonBackgroundCallCount;
end;

function TTestRickDialogProTheme.GetPrimaryButtonHoverBackgroundCallCount: Integer;
begin
  Result := PrimaryButtonHoverBackgroundCallCount;
end;

function TTestRickDialogProTheme.GetPrimaryButtonTextCallCount: Integer;
begin
  Result := PrimaryButtonTextCallCount;
end;

function TTestRickDialogProTheme.GetSecondaryButtonBackgroundCallCount: Integer;
begin
  Result := SecondaryButtonBackgroundCallCount;
end;

function TTestRickDialogProTheme.GetSecondaryButtonHoverBackgroundCallCount: Integer;
begin
  Result := SecondaryButtonHoverBackgroundCallCount;
end;

function TTestRickDialogProTheme.GetSecondaryButtonTextCallCount: Integer;
begin
  Result := SecondaryButtonTextCallCount;
end;

function TTestRickDialogProTheme.GetLastStatusColorKind: TRickDialogProKind;
begin
  Result := LastStatusColorKind;
end;

function TTestRickDialogProTheme.GetLastIconBackgroundKind: TRickDialogProKind;
begin
  Result := LastIconBackgroundKind;
end;

function TTestRickDialogProTheme.GetLastIconStrokeKind: TRickDialogProKind;
begin
  Result := LastIconStrokeKind;
end;

function TTestRickDialogProTheme.GetLastPrimaryButtonBackgroundKind:
  TRickDialogProKind;
begin
  Result := LastPrimaryButtonBackgroundKind;
end;

function TTestRickDialogProTheme.GetLastPrimaryButtonHoverBackgroundKind:
  TRickDialogProKind;
begin
  Result := LastPrimaryButtonHoverBackgroundKind;
end;

function TTestRickDialogProTheme.GetLastPrimaryButtonTextKind:
  TRickDialogProKind;
begin
  Result := LastPrimaryButtonTextKind;
end;

class function TTestRickDialogProTheme.New: ITestRickDialogProTheme;
begin
  Result := TTestRickDialogProTheme.Create;
end;

end.
