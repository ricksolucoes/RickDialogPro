unit Rick.Dialog.Pro.Tests.Runtime.Form;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TRuntimeFormTests = class
  public
    [Test]
    procedure Background_Disabled_PreservesTransparentFill;

    [Test]
    procedure Background_Enabled_UsesThemeBackground;

    [Test]
    procedure Card_UsesThemeSurfaceAndBorder;

    [Test]
    procedure Texts_UseThemePrimaryAndSecondaryColors;

    [Test]
    procedure SemanticVisuals_UseKindSpecificThemeValues;

    [Test]
    procedure PrimaryButton_UsesThemeColors;

    [Test]
    procedure SecondaryButton_ShowSecondaryFalse_DoesNotCreate;

    [Test]
    procedure SecondaryButton_BlankCaption_DoesNotCreate;

    [Test]
    procedure SecondaryButton_WithCaption_CreatesAndUsesThemeColors;

    [Test]
    procedure PrimaryButton_HoverUsesAndRestoresThemeColors;

    [Test]
    procedure SecondaryButton_HoverUsesAndRestoresThemeColors;

    [Test]
    procedure TextTooltip_LongTitle_ShowsAndHidesWithThemeColors;

    [Test]
    procedure TextTooltip_LongWrappedMessage_ShowsAndHides;

    [Test]
    procedure ButtonTooltip_LongCaption_ShowsAndHides;

    [Test]
    procedure Execute_CloseWithoutAction_ReturnsNone;

    [Test]
    procedure Execute_PrimaryClick_ReturnsPrimary;

    [Test]
    procedure Execute_SecondaryClick_ReturnsSecondary;
  end;

  [TestFixture]
  TFacadeTests = class
  public
    [Test]
    procedure New_DefaultTheme_ReturnsDialog;

    [Test]
    procedure New_CustomTheme_ReturnsDialog;

    [Test]
    procedure New_NilTheme_RaisesArgumentNil;

    [Test]
    procedure Execute_Primary_EndToEnd;

    [Test]
    procedure Error_Primary_EndToEnd;

    [Test]
    procedure Warning_Primary_EndToEnd;

    [Test]
    procedure Information_Primary_EndToEnd;

    [Test]
    procedure Success_Primary_EndToEnd;

    [Test]
    procedure Warning_Secondary_EndToEnd;
  end;

implementation

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,

  FMX.Forms,
  FMX.Objects,
  FMX.StdCtrls,

  Rick.Dialog.Pro,
  Rick.Dialog.Pro.Interf,
  Rick.Dialog.Pro.Theme.Interf,
  Rick.Dialog.Pro.Types,
  Rick.Dialog.Pro.Impl.FMX.RuntimeForm,

  Rick.Dialog.Pro.Tests.ThemeSpy,
  Rick.Dialog.Pro.Tests.FMX.Helpers;

type
  {$SCOPEDENUMS ON}
  TRickDialogProModalAction = (
    CloseWithoutSelection,
    ClickButton
  );
  {$SCOPEDENUMS OFF}

  TRickDialogProExecuteFunc = reference to function: TRickDialogProResult;

  TModalDriverContext = class
  strict private
    FForm: TRickDialogProRuntimeForm;
    FAction: TRickDialogProModalAction;
    FCaption: string;
    FExecuted: Boolean;
    FErrorMessage: string;

    function FindTargetForm: TRickDialogProRuntimeForm;
  public
    constructor Create(
      AForm: TRickDialogProRuntimeForm;
      AAction: TRickDialogProModalAction;
      const ACaption: string
    );

    procedure ExecuteQueuedAction;

    property Executed: Boolean read FExecuted;
    property ErrorMessage: string read FErrorMessage;
  end;

  TRickDialogProModalDriver = class sealed
  public
    class function ExecuteForm(
      AForm: TRickDialogProRuntimeForm;
      AAction: TRickDialogProModalAction;
      const ACaption: string = ''
    ): TRickDialogProResult; static;

    class function ExecuteActiveForm(
      const AExecute: TRickDialogProExecuteFunc;
      AAction: TRickDialogProModalAction;
      const ACaption: string = ''
    ): TRickDialogProResult; static;
  end;

constructor TModalDriverContext.Create(
  AForm: TRickDialogProRuntimeForm;
  AAction: TRickDialogProModalAction;
  const ACaption: string
);
begin
  inherited Create;

  FForm := AForm;
  FAction := AAction;
  FCaption := ACaption;
end;

function TModalDriverContext.FindTargetForm: TRickDialogProRuntimeForm;
var
  I: Integer;
begin
  Result := FForm;

  if Assigned(Result) then
    Exit;

  if not Assigned(Screen) then
    Exit(nil);

  if Screen.ActiveForm is TRickDialogProRuntimeForm then
    Exit(TRickDialogProRuntimeForm(Screen.ActiveForm));

  for I := Screen.FormCount - 1 downto 0 do
  begin
    if Screen.Forms[I] is TRickDialogProRuntimeForm then
      Exit(TRickDialogProRuntimeForm(Screen.Forms[I]));
  end;
end;

procedure TModalDriverContext.ExecuteQueuedAction;
var
  LForm: TRickDialogProRuntimeForm;
  LButton: TRectangle;
begin
  FExecuted := True;

  LForm := FindTargetForm;

  if not Assigned(LForm) then
  begin
    FErrorMessage := 'O formulario modal do RickDialogPro nao foi localizado.';
    Exit;
  end;

  case FAction of
    TRickDialogProModalAction.CloseWithoutSelection:
      LForm.ModalResult := mrCancel;

    TRickDialogProModalAction.ClickButton:
      begin
        LButton := FindActionButtonByCaption(LForm, FCaption);

        if not Assigned(LButton) then
        begin
          FErrorMessage := Format(
            'O botao "%s" nao foi localizado no formulario modal.',
            [FCaption]
          );
          LForm.ModalResult := mrCancel;
          Exit;
        end;

        if not Assigned(LButton.OnClick) then
        begin
          FErrorMessage := Format(
            'O botao "%s" nao possui evento OnClick.',
            [FCaption]
          );
          LForm.ModalResult := mrCancel;
          Exit;
        end;

        LButton.OnClick(LButton);
      end;
  end;
end;

class function TRickDialogProModalDriver.ExecuteForm(
  AForm: TRickDialogProRuntimeForm;
  AAction: TRickDialogProModalAction;
  const ACaption: string
): TRickDialogProResult;
var
  LContext: TModalDriverContext;
  LQueuedMethod: TThreadMethod;
begin
  if not Assigned(AForm) then
    raise EArgumentNilException.Create('O formulario modal nao foi informado.');

  LContext := TModalDriverContext.Create(AForm, AAction, ACaption);
  LQueuedMethod := LContext.ExecuteQueuedAction;

  TThread.ForceQueue(nil, LQueuedMethod);
  try
    Result := AForm.Execute;

    if not LContext.Executed then
      raise Exception.Create('A acao modal enfileirada nao foi executada.');

    if LContext.ErrorMessage <> EmptyStr then
      raise Exception.Create(LContext.ErrorMessage);
  finally
    if not LContext.Executed then
      TThread.RemoveQueuedEvents(nil, LQueuedMethod);

    LContext.Free;
  end;
end;

class function TRickDialogProModalDriver.ExecuteActiveForm(
  const AExecute: TRickDialogProExecuteFunc;
  AAction: TRickDialogProModalAction;
  const ACaption: string
): TRickDialogProResult;
var
  LContext: TModalDriverContext;
  LQueuedMethod: TThreadMethod;
begin
  if not Assigned(AExecute) then
    raise EArgumentNilException.Create('A execucao modal nao foi informada.');

  LContext := TModalDriverContext.Create(nil, AAction, ACaption);
  LQueuedMethod := LContext.ExecuteQueuedAction;

  TThread.ForceQueue(nil, LQueuedMethod);
  try
    Result := AExecute();

    if not LContext.Executed then
      raise Exception.Create('A acao modal enfileirada nao foi executada.');

    if LContext.ErrorMessage <> EmptyStr then
      raise Exception.Create(LContext.ErrorMessage);
  finally
    if not LContext.Executed then
      TThread.RemoveQueuedEvents(nil, LQueuedMethod);

    LContext.Free;
  end;
end;

procedure TRuntimeFormTests.Background_Disabled_PreservesTransparentFill;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
begin
  LConfig := TRickDialogProConfig.Default;
  LConfig.UseBackground := False;

  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    Assert.IsTrue(
      LForm.Transparency,
      'Transparency deveria permanecer True.'
    );

    Assert.AreEqual(
      TAlphaColor($00000000),
      LForm.Fill.Color,
      'O Fill deveria permanecer transparente quando UseBackground=False.'
    );

    Assert.AreEqual(
      0,
      LTheme.GetBackgroundCallCount,
      'Background nao deveria ser consultado quando UseBackground=False.'
    );
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.Background_Enabled_UsesThemeBackground;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
begin
  LConfig := TRickDialogProConfig.Default;
  LConfig.UseBackground := True;

  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    Assert.IsTrue(
      LForm.Transparency,
      'Transparency deveria permanecer True.'
    );

    Assert.AreEqual(
      _TEST_THEME_BACKGROUND,
      LForm.Fill.Color,
      'O Fill deveria utilizar Background do tema quando UseBackground=True.'
    );

    Assert.AreEqual(
      1,
      LTheme.GetBackgroundCallCount,
      'Background deveria ser consultado uma vez quando UseBackground=True.'
    );
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.Card_UsesThemeSurfaceAndBorder;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LCard: TRectangle;
begin
  LConfig := TRickDialogProConfig.Default;
  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    LCard := FindDirectRectangle(LForm);

    Assert.IsTrue(
      Assigned(LCard),
      'O card principal nao foi localizado.'
    );

    Assert.AreEqual(
      _TEST_THEME_SURFACE,
      LCard.Fill.Color,
      'O card principal deveria utilizar Surface do tema.'
    );

    Assert.AreEqual(
      _TEST_THEME_BORDER,
      LCard.Stroke.Color,
      'O card principal deveria utilizar Border do tema.'
    );

    Assert.AreEqual(
      1,
      LTheme.GetSurfaceCallCount,
      'Surface deveria ser consultado uma vez para criar o card principal.'
    );

    Assert.AreEqual(
      1,
      LTheme.GetBorderCallCount,
      'Border deveria ser consultado uma vez para criar o card principal.'
    );
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.Texts_UseThemePrimaryAndSecondaryColors;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LTitle: TLabel;
  LMessage: TLabel;
begin
  LConfig := TRickDialogProConfig.Information(
    'Titulo de Teste',
    'Mensagem de Teste'
  );

  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    LTitle := FindLabelByText(LForm, 'Titulo de Teste');
    LMessage := FindLabelByText(LForm, 'Mensagem de Teste');

    Assert.IsTrue(
      Assigned(LTitle),
      'O titulo nao foi localizado.'
    );

    Assert.IsTrue(
      Assigned(LMessage),
      'A mensagem nao foi localizada.'
    );

    Assert.IsFalse(
      LTitle.HitTest,
      'Titulo curto nao deveria habilitar tooltip.'
    );

    Assert.IsFalse(
      LMessage.HitTest,
      'Mensagem curta nao deveria habilitar tooltip.'
    );

    Assert.AreEqual(
      _TEST_THEME_TEXT_PRIMARY,
      LTitle.TextSettings.FontColor,
      'O titulo deveria utilizar TextPrimary do tema.'
    );

    Assert.AreEqual(
      _TEST_THEME_TEXT_SECONDARY,
      LMessage.TextSettings.FontColor,
      'A mensagem deveria utilizar TextSecondary do tema.'
    );

    Assert.AreEqual(
      1,
      LTheme.GetTextPrimaryCallCount,
      'TextPrimary deveria ser consultado uma vez para o titulo.'
    );

    Assert.AreEqual(
      1,
      LTheme.GetTextSecondaryCallCount,
      'TextSecondary deveria ser consultado uma vez para a mensagem.'
    );
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.SemanticVisuals_UseKindSpecificThemeValues;
const
  _KINDS: array[0..3] of TRickDialogProKind = (
    TRickDialogProKind.Error,
    TRickDialogProKind.Warning,
    TRickDialogProKind.Information,
    TRickDialogProKind.Success
  );
var
  I: Integer;
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LCard: TRectangle;
  LTopBar: TPath;
  LCircle: TCircle;
  LIconPath: TPath;
begin
  for I := Low(_KINDS) to High(_KINDS) do
  begin
    LConfig := TRickDialogProConfig.Default;
    LConfig.Kind := _KINDS[I];
    LConfig.Title := 'Titulo';
    LConfig.MessageText := 'Mensagem';
    LConfig.PrimaryCaption := 'Confirmar';

    LTheme := TTestRickDialogProTheme.New;

    LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
    try
      LCard := FindDirectRectangle(LForm);
      Assert.IsTrue(Assigned(LCard), 'O card principal nao foi localizado.');

      LTopBar := FindDirectPath(LCard);
      Assert.IsTrue(Assigned(LTopBar), 'A barra semantica nao foi localizada.');

      LCircle := FindDirectCircle(LCard);
      Assert.IsTrue(Assigned(LCircle), 'O circulo do icone nao foi localizado.');

      LIconPath := FindDirectPath(LCircle);
      Assert.IsTrue(Assigned(LIconPath), 'O path do icone nao foi localizado.');

      Assert.AreEqual(
        _TEST_THEME_STATUS,
        LTopBar.Stroke.Color,
        'A barra superior deveria utilizar StatusColor do tema.'
      );

      Assert.AreEqual(
        _TEST_THEME_ICON_BACKGROUND,
        LCircle.Fill.Color,
        'O circulo deveria utilizar IconBackground do tema.'
      );

      Assert.AreEqual(
        _TEST_THEME_ICON_STROKE,
        LIconPath.Fill.Color,
        'O icone deveria utilizar IconStroke do tema.'
      );

      Assert.AreEqual(1, LTheme.GetStatusColorCallCount);
      Assert.AreEqual(1, LTheme.GetIconBackgroundCallCount);
      Assert.AreEqual(1, LTheme.GetIconStrokeCallCount);
      Assert.AreEqual(1, LTheme.GetPrimaryButtonBackgroundCallCount);
      Assert.AreEqual(1, LTheme.GetPrimaryButtonTextCallCount);

      Assert.AreEqual(
        Ord(_KINDS[I]),
        Ord(LTheme.GetLastStatusColorKind),
        'StatusColor recebeu um Kind diferente da configuracao.'
      );

      Assert.AreEqual(
        Ord(_KINDS[I]),
        Ord(LTheme.GetLastIconBackgroundKind),
        'IconBackground recebeu um Kind diferente da configuracao.'
      );

      Assert.AreEqual(
        Ord(_KINDS[I]),
        Ord(LTheme.GetLastIconStrokeKind),
        'IconStroke recebeu um Kind diferente da configuracao.'
      );

      Assert.AreEqual(
        Ord(_KINDS[I]),
        Ord(LTheme.GetLastPrimaryButtonBackgroundKind),
        'PrimaryButtonBackground recebeu um Kind diferente da configuracao.'
      );

      Assert.AreEqual(
        Ord(_KINDS[I]),
        Ord(LTheme.GetLastPrimaryButtonTextKind),
        'PrimaryButtonText recebeu um Kind diferente da configuracao.'
      );
    finally
      LForm.Free;
    end;
  end;
end;

procedure TRuntimeFormTests.PrimaryButton_UsesThemeColors;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LButton: TRectangle;
  LLabel: TLabel;
begin
  LConfig := TRickDialogProConfig.Warning(
    'Titulo',
    'Mensagem',
    'Confirmar'
  );

  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    LButton := FindActionButtonByCaption(LForm, 'Confirmar');

    Assert.IsTrue(
      Assigned(LButton),
      'O botao principal nao foi localizado.'
    );

    LLabel := FindDirectLabelByText(LButton, 'Confirmar');

    Assert.IsTrue(
      Assigned(LLabel),
      'O texto do botao principal nao foi localizado.'
    );

    Assert.IsFalse(
      LLabel.HitTest,
      'O label do botao principal nao deve interceptar o clique.'
    );

    Assert.AreEqual(
      _TEST_THEME_PRIMARY_BUTTON_BACKGROUND,
      LButton.Fill.Color,
      'O botao principal deveria utilizar PrimaryButtonBackground.'
    );

    Assert.AreEqual(
      _TEST_THEME_PRIMARY_BUTTON_TEXT,
      LLabel.TextSettings.FontColor,
      'O texto do botao principal deveria utilizar PrimaryButtonText.'
    );

    Assert.AreEqual(1, LTheme.GetPrimaryButtonBackgroundCallCount);
    Assert.AreEqual(1, LTheme.GetPrimaryButtonTextCallCount);
    Assert.AreEqual(0, LTheme.GetPrimaryButtonHoverBackgroundCallCount);

    Assert.AreEqual(
      Ord(TRickDialogProKind.Warning),
      Ord(LTheme.GetLastPrimaryButtonBackgroundKind)
    );

    Assert.AreEqual(
      Ord(TRickDialogProKind.Warning),
      Ord(LTheme.GetLastPrimaryButtonTextKind)
    );
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.SecondaryButton_ShowSecondaryFalse_DoesNotCreate;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
begin
  LConfig := TRickDialogProConfig.Default;
  LConfig.Title := 'Titulo';
  LConfig.MessageText := 'Mensagem';
  LConfig.PrimaryCaption := 'Primaria';
  LConfig.SecondaryCaption := 'Secundaria';
  LConfig.ShowSecondary := False;

  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    Assert.IsFalse(
      Assigned(FindActionButtonByCaption(LForm, 'Secundaria')),
      'O botao secundario nao deveria existir quando ShowSecondary=False.'
    );

    Assert.AreEqual(0, LTheme.GetSecondaryButtonBackgroundCallCount);
    Assert.AreEqual(0, LTheme.GetSecondaryButtonTextCallCount);
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.SecondaryButton_BlankCaption_DoesNotCreate;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
begin
  LConfig := TRickDialogProConfig.Default;
  LConfig.Title := 'Titulo';
  LConfig.MessageText := 'Mensagem';
  LConfig.PrimaryCaption := 'Primaria';
  LConfig.SecondaryCaption := '   ';
  LConfig.ShowSecondary := True;

  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    Assert.IsFalse(
      Assigned(FindActionButtonByCaption(LForm, '   ')),
      'O botao secundario nao deveria existir para caption em branco.'
    );

    Assert.AreEqual(0, LTheme.GetSecondaryButtonBackgroundCallCount);
    Assert.AreEqual(0, LTheme.GetSecondaryButtonTextCallCount);
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.SecondaryButton_WithCaption_CreatesAndUsesThemeColors;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LButton: TRectangle;
  LLabel: TLabel;
begin
  LConfig := TRickDialogProConfig.Information(
    'Titulo',
    'Mensagem',
    'Primaria',
    'Secundaria'
  );

  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    LButton := FindActionButtonByCaption(LForm, 'Secundaria');

    Assert.IsTrue(
      Assigned(LButton),
      'O botao secundario deveria ter sido criado.'
    );

    LLabel := FindDirectLabelByText(LButton, 'Secundaria');

    Assert.IsTrue(
      Assigned(LLabel),
      'O texto do botao secundario nao foi localizado.'
    );

    Assert.IsFalse(
      LLabel.HitTest,
      'O label do botao secundario nao deve interceptar o clique.'
    );

    Assert.AreEqual(
      _TEST_THEME_SECONDARY_BUTTON_BACKGROUND,
      LButton.Fill.Color,
      'O botao secundario deveria utilizar SecondaryButtonBackground.'
    );

    Assert.AreEqual(
      _TEST_THEME_SECONDARY_BUTTON_TEXT,
      LLabel.TextSettings.FontColor,
      'O texto do botao secundario deveria utilizar SecondaryButtonText.'
    );

    Assert.AreEqual(1, LTheme.GetSecondaryButtonBackgroundCallCount);
    Assert.AreEqual(1, LTheme.GetSecondaryButtonTextCallCount);
    Assert.AreEqual(0, LTheme.GetSecondaryButtonHoverBackgroundCallCount);
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.PrimaryButton_HoverUsesAndRestoresThemeColors;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LButton: TRectangle;
begin
  LConfig := TRickDialogProConfig.Success(
    'Titulo',
    'Mensagem',
    'Confirmar'
  );

  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    LButton := FindActionButtonByCaption(LForm, 'Confirmar');

    Assert.IsTrue(Assigned(LButton), 'O botao principal nao foi localizado.');
    Assert.IsTrue(Assigned(LButton.OnMouseEnter));
    Assert.IsTrue(Assigned(LButton.OnMouseLeave));

    LButton.OnMouseEnter(LButton);

    Assert.AreEqual(
      _TEST_THEME_PRIMARY_BUTTON_HOVER_BACKGROUND,
      LButton.Fill.Color,
      'O hover principal deveria utilizar a cor de hover do tema.'
    );

    Assert.AreEqual(1, LTheme.GetPrimaryButtonHoverBackgroundCallCount);

    Assert.AreEqual(
      Ord(TRickDialogProKind.Success),
      Ord(LTheme.GetLastPrimaryButtonHoverBackgroundKind)
    );

    LButton.OnMouseLeave(LButton);

    Assert.AreEqual(
      _TEST_THEME_PRIMARY_BUTTON_BACKGROUND,
      LButton.Fill.Color,
      'Ao sair do hover, a cor normal deveria ser restaurada.'
    );

    Assert.AreEqual(2, LTheme.GetPrimaryButtonBackgroundCallCount);
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.SecondaryButton_HoverUsesAndRestoresThemeColors;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LButton: TRectangle;
begin
  LConfig := TRickDialogProConfig.Warning(
    'Titulo',
    'Mensagem',
    'Primaria',
    'Secundaria'
  );

  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    LButton := FindActionButtonByCaption(LForm, 'Secundaria');

    Assert.IsTrue(Assigned(LButton), 'O botao secundario nao foi localizado.');
    Assert.IsTrue(Assigned(LButton.OnMouseEnter));
    Assert.IsTrue(Assigned(LButton.OnMouseLeave));

    LButton.OnMouseEnter(LButton);

    Assert.AreEqual(
      _TEST_THEME_SECONDARY_BUTTON_HOVER_BACKGROUND,
      LButton.Fill.Color,
      'O hover secundario deveria utilizar a cor de hover do tema.'
    );

    Assert.AreEqual(1, LTheme.GetSecondaryButtonHoverBackgroundCallCount);

    LButton.OnMouseLeave(LButton);

    Assert.AreEqual(
      _TEST_THEME_SECONDARY_BUTTON_BACKGROUND,
      LButton.Fill.Color,
      'Ao sair do hover, a cor secundaria normal deveria ser restaurada.'
    );

    Assert.AreEqual(2, LTheme.GetSecondaryButtonBackgroundCallCount);
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.TextTooltip_LongTitle_ShowsAndHidesWithThemeColors;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LCard: TRectangle;
  LTitle: TLabel;
  LTooltip: TRectangle;
  LTooltipLabel: TLabel;
  LTitleText: string;
begin
  LTitleText := StringOfChar('W', 400);

  LConfig := TRickDialogProConfig.Information(
    LTitleText,
    'Mensagem curta',
    'Confirmar'
  );

  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    LCard := FindDirectRectangle(LForm);
    LTitle := FindLabelByText(LForm, LTitleText);

    Assert.IsTrue(Assigned(LCard), 'O card principal nao foi localizado.');
    Assert.IsTrue(Assigned(LTitle), 'O titulo longo nao foi localizado.');
    Assert.IsTrue(LTitle.HitTest, 'O titulo truncado deveria aceitar hover.');
    Assert.IsTrue(Assigned(LTitle.OnMouseEnter));
    Assert.IsTrue(Assigned(LTitle.OnMouseLeave));

    Assert.IsFalse(
      Assigned(FindPassiveRectangleWithDirectLabelText(LCard, LTitleText)),
      'O tooltip nao deveria existir antes do primeiro hover.'
    );

    LTitle.OnMouseEnter(LTitle);

    LTooltip := FindPassiveRectangleWithDirectLabelText(LCard, LTitleText);

    Assert.IsTrue(Assigned(LTooltip), 'O tooltip do titulo nao foi localizado.');
    Assert.IsTrue(LTooltip.Visible, 'O tooltip deveria estar visivel.');

    Assert.AreEqual(
      _TEST_THEME_SURFACE_ELEVATED,
      LTooltip.Fill.Color,
      'O tooltip deveria utilizar SurfaceElevated.'
    );

    Assert.AreEqual(
      _TEST_THEME_BORDER,
      LTooltip.Stroke.Color,
      'O tooltip deveria utilizar Border.'
    );

    LTooltipLabel := FindDirectLabelByText(LTooltip, LTitleText);
    Assert.IsTrue(Assigned(LTooltipLabel));

    Assert.AreEqual(
      _TEST_THEME_TEXT_PRIMARY,
      LTooltipLabel.TextSettings.FontColor,
      'O texto do tooltip deveria utilizar TextPrimary.'
    );

    Assert.AreEqual(1, LTheme.GetSurfaceElevatedCallCount);
    Assert.AreEqual(2, LTheme.GetBorderCallCount);
    Assert.AreEqual(2, LTheme.GetTextPrimaryCallCount);

    LTitle.OnMouseLeave(LTitle);

    Assert.IsFalse(
      LTooltip.Visible,
      'O tooltip deveria ser ocultado no MouseLeave.'
    );
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.TextTooltip_LongWrappedMessage_ShowsAndHides;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LCard: TRectangle;
  LMessage: TLabel;
  LTooltip: TRectangle;
  LMessageText: string;
  I: Integer;
begin
  LMessageText := EmptyStr;

  for I := 1 to 100 do
    LMessageText := LMessageText + 'palavra ';

  LConfig := TRickDialogProConfig.Information(
    'Titulo curto',
    LMessageText,
    'Confirmar'
  );

  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    LCard := FindDirectRectangle(LForm);
    LMessage := FindLabelByText(LForm, LMessageText);

    Assert.IsTrue(Assigned(LCard), 'O card principal nao foi localizado.');
    Assert.IsTrue(Assigned(LMessage), 'A mensagem longa nao foi localizada.');
    Assert.IsTrue(LMessage.WordWrap, 'A mensagem deveria utilizar WordWrap.');
    Assert.IsTrue(
      LMessage.HitTest,
      'A mensagem truncada deveria aceitar hover.'
    );
    Assert.IsTrue(Assigned(LMessage.OnMouseEnter));
    Assert.IsTrue(Assigned(LMessage.OnMouseLeave));

    LMessage.OnMouseEnter(LMessage);

    LTooltip := FindPassiveRectangleWithDirectLabelText(LCard, LMessageText);

    Assert.IsTrue(
      Assigned(LTooltip),
      'O tooltip da mensagem longa nao foi localizado.'
    );
    Assert.IsTrue(LTooltip.Visible);

    LMessage.OnMouseLeave(LMessage);

    Assert.IsFalse(
      LTooltip.Visible,
      'O tooltip da mensagem deveria ser ocultado no MouseLeave.'
    );
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.ButtonTooltip_LongCaption_ShowsAndHides;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LCard: TRectangle;
  LButton: TRectangle;
  LTooltip: TRectangle;
  LCaption: string;
begin
  LCaption := StringOfChar('W', 200);

  LConfig := TRickDialogProConfig.Information(
    'Titulo',
    'Mensagem',
    LCaption
  );

  LTheme := TTestRickDialogProTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    LCard := FindDirectRectangle(LForm);
    LButton := FindActionButtonByCaption(LForm, LCaption);

    Assert.IsTrue(Assigned(LCard));
    Assert.IsTrue(Assigned(LButton), 'O botao de caption longo nao foi localizado.');

    Assert.IsFalse(
      Assigned(FindPassiveRectangleWithDirectLabelText(LCard, LCaption)),
      'O tooltip nao deveria existir antes do hover do botao.'
    );

    LButton.OnMouseEnter(LButton);

    LTooltip := FindPassiveRectangleWithDirectLabelText(LCard, LCaption);

    Assert.IsTrue(Assigned(LTooltip), 'O tooltip do botao nao foi localizado.');
    Assert.IsTrue(LTooltip.Visible, 'O tooltip do botao deveria estar visivel.');
    Assert.AreEqual(1, LTheme.GetSurfaceElevatedCallCount);

    LButton.OnMouseLeave(LButton);

    Assert.IsFalse(
      LTooltip.Visible,
      'O tooltip do botao deveria ser ocultado no MouseLeave.'
    );
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.Execute_CloseWithoutAction_ReturnsNone;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LResult: TRickDialogProResult;
begin
  LConfig := TRickDialogProConfig.Information(
    'Titulo',
    'Mensagem',
    'Confirmar'
  );

  LTheme := TTestRickDialogProTheme.New;
  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    LResult := TRickDialogProModalDriver.ExecuteForm(
      LForm,
      TRickDialogProModalAction.CloseWithoutSelection
    );

    Assert.AreEqual(
      Ord(TRickDialogProResult.None),
      Ord(LResult),
      'Fechar sem selecionar uma acao deveria retornar None.'
    );
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.Execute_PrimaryClick_ReturnsPrimary;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LResult: TRickDialogProResult;
begin
  LConfig := TRickDialogProConfig.Information(
    'Titulo',
    'Mensagem',
    'Confirmar'
  );

  LTheme := TTestRickDialogProTheme.New;
  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    LResult := TRickDialogProModalDriver.ExecuteForm(
      LForm,
      TRickDialogProModalAction.ClickButton,
      'Confirmar'
    );

    Assert.AreEqual(
      Ord(TRickDialogProResult.Primary),
      Ord(LResult),
      'O clique no botao principal deveria retornar Primary.'
    );
  finally
    LForm.Free;
  end;
end;

procedure TRuntimeFormTests.Execute_SecondaryClick_ReturnsSecondary;
var
  LConfig: TRickDialogProConfig;
  LTheme: ITestRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LResult: TRickDialogProResult;
begin
  LConfig := TRickDialogProConfig.Warning(
    'Titulo',
    'Mensagem',
    'Primaria',
    'Secundaria'
  );

  LTheme := TTestRickDialogProTheme.New;
  LForm := TRickDialogProRuntimeForm.Create(nil, LConfig, LTheme);
  try
    LResult := TRickDialogProModalDriver.ExecuteForm(
      LForm,
      TRickDialogProModalAction.ClickButton,
      'Secundaria'
    );

    Assert.AreEqual(
      Ord(TRickDialogProResult.Secondary),
      Ord(LResult),
      'O clique no botao secundario deveria retornar Secondary.'
    );
  finally
    LForm.Free;
  end;
end;

procedure TFacadeTests.New_DefaultTheme_ReturnsDialog;
var
  LDialog: IRickDialogPro;
begin
  LDialog := TRickDialogPro.New;

  Assert.IsTrue(
    Assigned(LDialog),
    'TRickDialogPro.New deveria retornar uma instancia valida.'
  );
end;

procedure TFacadeTests.New_CustomTheme_ReturnsDialog;
var
  LTheme: ITestRickDialogProTheme;
  LDialog: IRickDialogPro;
begin
  LTheme := TTestRickDialogProTheme.New;
  LDialog := TRickDialogPro.New(LTheme);

  Assert.IsTrue(
    Assigned(LDialog),
    'TRickDialogPro.New(ATheme) deveria retornar uma instancia valida.'
  );
end;

procedure TFacadeTests.New_NilTheme_RaisesArgumentNil;
var
  LTheme: IRickDialogProTheme;
  LDialog: IRickDialogPro;
  LRaised: Boolean;
begin
  LTheme := nil;
  LDialog := nil;
  LRaised := False;

  try
    LDialog := TRickDialogPro.New(LTheme);
  except
    on E: EArgumentNilException do
      LRaised := True;
  end;

  Assert.IsTrue(
    LRaised,
    'TRickDialogPro.New(nil) deveria lancar EArgumentNilException.'
  );

  Assert.IsFalse(Assigned(LDialog));
end;

procedure TFacadeTests.Execute_Primary_EndToEnd;
var
  LTheme: ITestRickDialogProTheme;
  LDialog: IRickDialogPro;
  LConfig: TRickDialogProConfig;
  LResult: TRickDialogProResult;
begin
  LTheme := TTestRickDialogProTheme.New;
  LDialog := TRickDialogPro.New(LTheme);

  LConfig := TRickDialogProConfig.Information(
    'Titulo',
    'Mensagem',
    'Executar'
  );
  LConfig.UseBackground := True;

  LResult := TRickDialogProModalDriver.ExecuteActiveForm(
    function: TRickDialogProResult
    begin
      Result := LDialog.Execute(LConfig);
    end,
    TRickDialogProModalAction.ClickButton,
    'Executar'
  );

  Assert.AreEqual(
    Ord(TRickDialogProResult.Primary),
    Ord(LResult)
  );

  Assert.AreEqual(1, LTheme.GetBackgroundCallCount);

  Assert.AreEqual(
    Ord(TRickDialogProKind.Information),
    Ord(LTheme.GetLastStatusColorKind)
  );
end;

procedure TFacadeTests.Error_Primary_EndToEnd;
var
  LTheme: ITestRickDialogProTheme;
  LDialog: IRickDialogPro;
  LResult: TRickDialogProResult;
begin
  LTheme := TTestRickDialogProTheme.New;
  LDialog := TRickDialogPro.New(LTheme);

  LResult := TRickDialogProModalDriver.ExecuteActiveForm(
    function: TRickDialogProResult
    begin
      Result := LDialog.Error(
        'Erro',
        'Mensagem'
      );
    end,
    TRickDialogProModalAction.ClickButton,
    'Fechar'
  );

  Assert.AreEqual(Ord(TRickDialogProResult.Primary), Ord(LResult));
  Assert.AreEqual(
    Ord(TRickDialogProKind.Error),
    Ord(LTheme.GetLastStatusColorKind)
  );
end;

procedure TFacadeTests.Warning_Primary_EndToEnd;
var
  LTheme: ITestRickDialogProTheme;
  LDialog: IRickDialogPro;
  LResult: TRickDialogProResult;
begin
  LTheme := TTestRickDialogProTheme.New;
  LDialog := TRickDialogPro.New(LTheme);

  LResult := TRickDialogProModalDriver.ExecuteActiveForm(
    function: TRickDialogProResult
    begin
      Result := LDialog.Warning(
        'Atencao',
        'Mensagem'
      );
    end,
    TRickDialogProModalAction.ClickButton,
    'Entendi'
  );

  Assert.AreEqual(Ord(TRickDialogProResult.Primary), Ord(LResult));
  Assert.AreEqual(
    Ord(TRickDialogProKind.Warning),
    Ord(LTheme.GetLastStatusColorKind)
  );
end;

procedure TFacadeTests.Information_Primary_EndToEnd;
var
  LTheme: ITestRickDialogProTheme;
  LDialog: IRickDialogPro;
  LResult: TRickDialogProResult;
begin
  LTheme := TTestRickDialogProTheme.New;
  LDialog := TRickDialogPro.New(LTheme);

  LResult := TRickDialogProModalDriver.ExecuteActiveForm(
    function: TRickDialogProResult
    begin
      Result := LDialog.Information(
        'Informacao',
        'Mensagem'
      );
    end,
    TRickDialogProModalAction.ClickButton,
    'Entendi'
  );

  Assert.AreEqual(Ord(TRickDialogProResult.Primary), Ord(LResult));
  Assert.AreEqual(
    Ord(TRickDialogProKind.Information),
    Ord(LTheme.GetLastStatusColorKind)
  );
end;

procedure TFacadeTests.Success_Primary_EndToEnd;
var
  LTheme: ITestRickDialogProTheme;
  LDialog: IRickDialogPro;
  LResult: TRickDialogProResult;
begin
  LTheme := TTestRickDialogProTheme.New;
  LDialog := TRickDialogPro.New(LTheme);

  LResult := TRickDialogProModalDriver.ExecuteActiveForm(
    function: TRickDialogProResult
    begin
      Result := LDialog.Success(
        'Sucesso',
        'Mensagem'
      );
    end,
    TRickDialogProModalAction.ClickButton,
    'Concluir'
  );

  Assert.AreEqual(Ord(TRickDialogProResult.Primary), Ord(LResult));
  Assert.AreEqual(
    Ord(TRickDialogProKind.Success),
    Ord(LTheme.GetLastStatusColorKind)
  );
end;

procedure TFacadeTests.Warning_Secondary_EndToEnd;
var
  LTheme: ITestRickDialogProTheme;
  LDialog: IRickDialogPro;
  LResult: TRickDialogProResult;
begin
  LTheme := TTestRickDialogProTheme.New;
  LDialog := TRickDialogPro.New(LTheme);

  LResult := TRickDialogProModalDriver.ExecuteActiveForm(
    function: TRickDialogProResult
    begin
      Result := LDialog.Warning(
        'Atencao',
        'Mensagem',
        'Primaria',
        'Secundaria'
      );
    end,
    TRickDialogProModalAction.ClickButton,
    'Secundaria'
  );

  Assert.AreEqual(
    Ord(TRickDialogProResult.Secondary),
    Ord(LResult)
  );

  Assert.AreEqual(
    Ord(TRickDialogProKind.Warning),
    Ord(LTheme.GetLastStatusColorKind)
  );
end;

initialization
  TDUnitX.RegisterTestFixture(TRuntimeFormTests);
  TDUnitX.RegisterTestFixture(TFacadeTests);

end.
