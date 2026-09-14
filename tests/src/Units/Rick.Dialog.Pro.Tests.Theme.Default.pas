unit Rick.Dialog.Pro.Tests.Theme.Default;

interface

uses
  System.UITypes,

  DUnitX.TestFramework,

  Rick.Dialog.Pro.Types;

type
  [TestFixture]
  TDefaultThemeTests = class
  private
    procedure ValidateSemanticColors(
      const AKind: TRickDialogProKind;
      const AStatusColor: TAlphaColor;
      const AIconBackground: TAlphaColor;
      const AIconStroke: TAlphaColor;
      const APrimaryBackground: TAlphaColor;
      const APrimaryHoverBackground: TAlphaColor;
      const APrimaryText: TAlphaColor
    );
  public
    [Test]
    procedure New_ReturnsTheme;

    [Test]
    procedure BaseColors_ReturnExpectedValues;

    [Test]
    procedure Error_ReturnsExpectedSemanticColors;

    [Test]
    procedure Warning_ReturnsExpectedSemanticColors;

    [Test]
    procedure Information_ReturnsExpectedSemanticColors;

    [Test]
    procedure Success_ReturnsExpectedSemanticColors;

    [Test]
    procedure SecondaryButton_ReturnsExpectedColors;
  end;

implementation

uses
  Rick.Dialog.Pro.Theme.Interf,
  Rick.Dialog.Pro.Theme.Default,
  Rick.Dialog.Pro.Theme.Default.Colors;

procedure TDefaultThemeTests.ValidateSemanticColors(
  const AKind: TRickDialogProKind;
  const AStatusColor: TAlphaColor;
  const AIconBackground: TAlphaColor;
  const AIconStroke: TAlphaColor;
  const APrimaryBackground: TAlphaColor;
  const APrimaryHoverBackground: TAlphaColor;
  const APrimaryText: TAlphaColor
);
var
  LTheme: IRickDialogProTheme;
begin
  LTheme := TRickDialogProDefaultTheme.New;

  Assert.AreEqual(
    AStatusColor,
    LTheme.StatusColor(AKind)
  );

  Assert.AreEqual(
    AIconBackground,
    LTheme.IconBackground(AKind)
  );

  Assert.AreEqual(
    AIconStroke,
    LTheme.IconStroke(AKind)
  );

  Assert.AreEqual(
    APrimaryBackground,
    LTheme.PrimaryButtonBackground(AKind)
  );

  Assert.AreEqual(
    APrimaryHoverBackground,
    LTheme.PrimaryButtonHoverBackground(AKind)
  );

  Assert.AreEqual(
    APrimaryText,
    LTheme.PrimaryButtonText(AKind)
  );
end;

procedure TDefaultThemeTests.New_ReturnsTheme;
var
  LTheme: IRickDialogProTheme;
begin
  LTheme := TRickDialogProDefaultTheme.New;

  Assert.IsTrue(
    Assigned(LTheme),
    'TRickDialogProDefaultTheme.New deveria retornar um tema.'
  );
end;

procedure TDefaultThemeTests.BaseColors_ReturnExpectedValues;
var
  LTheme: IRickDialogProTheme;
begin
  LTheme := TRickDialogProDefaultTheme.New;

  Assert.AreEqual(
    _RICK_DIALOG_PRO_BACKGROUND,
    LTheme.Background
  );

  Assert.AreEqual(
    _RICK_DIALOG_PRO_SURFACE,
    LTheme.Surface
  );

  Assert.AreEqual(
    _RICK_DIALOG_PRO_SURFACE_ELEVATED,
    LTheme.SurfaceElevated
  );

  Assert.AreEqual(
    _RICK_DIALOG_PRO_BORDER,
    LTheme.Border
  );

  Assert.AreEqual(
    _RICK_DIALOG_PRO_TEXT_PRIMARY,
    LTheme.TextPrimary
  );

  Assert.AreEqual(
    _RICK_DIALOG_PRO_TEXT_SECONDARY,
    LTheme.TextSecondary
  );
end;

procedure TDefaultThemeTests.Error_ReturnsExpectedSemanticColors;
begin
  ValidateSemanticColors(
    TRickDialogProKind.Error,
    _RICK_DIALOG_PRO_BORDER_ERROR,
    _RICK_DIALOG_PRO_ICON_BG_ERROR,
    _RICK_DIALOG_PRO_ICON_STROKE_ERROR,
    _RICK_DIALOG_PRO_BUTTON_ERROR_BG,
    _RICK_DIALOG_PRO_BUTTON_ERROR_HOVER_BG,
    _RICK_DIALOG_PRO_BUTTON_ERROR_TEXT
  );
end;

procedure TDefaultThemeTests.Warning_ReturnsExpectedSemanticColors;
begin
  ValidateSemanticColors(
    TRickDialogProKind.Warning,
    _RICK_DIALOG_PRO_BORDER_WARNING,
    _RICK_DIALOG_PRO_ICON_BG_WARNING,
    _RICK_DIALOG_PRO_ICON_STROKE_WARNING,
    _RICK_DIALOG_PRO_BUTTON_WARNING_BG,
    _RICK_DIALOG_PRO_BUTTON_WARNING_HOVER_BG,
    _RICK_DIALOG_PRO_BUTTON_WARNING_TEXT
  );
end;

procedure TDefaultThemeTests.Information_ReturnsExpectedSemanticColors;
begin
  ValidateSemanticColors(
    TRickDialogProKind.Information,
    _RICK_DIALOG_PRO_BORDER_INFORMATION,
    _RICK_DIALOG_PRO_ICON_BG_INFORMATION,
    _RICK_DIALOG_PRO_ICON_STROKE_INFORMATION,
    _RICK_DIALOG_PRO_BUTTON_INFORMATION_BG,
    _RICK_DIALOG_PRO_BUTTON_INFORMATION_HOVER_BG,
    _RICK_DIALOG_PRO_BUTTON_INFORMATION_TEXT
  );
end;

procedure TDefaultThemeTests.Success_ReturnsExpectedSemanticColors;
begin
  ValidateSemanticColors(
    TRickDialogProKind.Success,
    _RICK_DIALOG_PRO_BORDER_SUCCESS,
    _RICK_DIALOG_PRO_ICON_BG_SUCCESS,
    _RICK_DIALOG_PRO_ICON_STROKE_SUCCESS,
    _RICK_DIALOG_PRO_BUTTON_SUCCESS_BG,
    _RICK_DIALOG_PRO_BUTTON_SUCCESS_HOVER_BG,
    _RICK_DIALOG_PRO_BUTTON_SUCCESS_TEXT
  );
end;

procedure TDefaultThemeTests.SecondaryButton_ReturnsExpectedColors;
var
  LTheme: IRickDialogProTheme;
begin
  LTheme := TRickDialogProDefaultTheme.New;

  Assert.AreEqual(
    _RICK_DIALOG_PRO_BUTTON_SECONDARY_BG,
    LTheme.SecondaryButtonBackground
  );

  Assert.AreEqual(
    _RICK_DIALOG_PRO_BUTTON_SECONDARY_HOVER_BG,
    LTheme.SecondaryButtonHoverBackground
  );

  Assert.AreEqual(
    _RICK_DIALOG_PRO_BUTTON_SECONDARY_TEXT,
    LTheme.SecondaryButtonText
  );
end;

initialization
  TDUnitX.RegisterTestFixture(TDefaultThemeTests);

end.
