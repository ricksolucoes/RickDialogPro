unit Rick.Dialog.Pro.Tests.Environment;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TEnvironmentTests = class
  public
    [Test]
    procedure FMXEnvironment_CanSafelyCreateAndManipulateControls;

    [Test]
    procedure RuntimeForm_CanBeCreatedAndDestroyed;

    [Test]
    procedure RuntimeForm_ControlsCanBeLocated;
  end;

implementation

uses
  System.Classes,

  FMX.Forms,
  FMX.Objects,
  FMX.StdCtrls,

  Rick.Dialog.Pro.Types,
  Rick.Dialog.Pro.Theme.Interf,
  Rick.Dialog.Pro.Theme.Default,
  Rick.Dialog.Pro.Impl.FMX.Runtime.Form,

  Rick.Dialog.Pro.Tests.FMX.Helpers;

procedure TEnvironmentTests.FMXEnvironment_CanSafelyCreateAndManipulateControls;
var
  LForm: TForm;
  LRectangle: TRectangle;
  LLabel: TLabel;
begin
  Assert.IsTrue(
    TThread.CurrentThread.ThreadID = MainThreadID,
    'O teste FMX nao esta executando na main thread.'
  );

  LForm := TForm.CreateNew(nil);
  try
    LForm.Caption := 'FMX Environment Test';
    LForm.Width := 400;
    LForm.Height := 300;

    LRectangle := TRectangle.Create(LForm);
    LRectangle.Parent := LForm;
    LRectangle.SetBounds(10, 10, 200, 100);

    LLabel := TLabel.Create(LForm);
    LLabel.Parent := LRectangle;
    LLabel.Text := 'RickDialogPro Test';

    Assert.AreEqual(
      'FMX Environment Test',
      LForm.Caption
    );

    Assert.AreEqual(
      'RickDialogPro Test',
      LLabel.Text
    );

    Assert.IsTrue(
      LRectangle.Parent = LForm,
      'O TRectangle nao foi associado ao formulario.'
    );

    Assert.IsTrue(
      LLabel.Parent = LRectangle,
      'O TLabel nao foi associado ao TRectangle.'
    );
  finally
    LForm.Free;
  end;
end;

procedure TEnvironmentTests.RuntimeForm_CanBeCreatedAndDestroyed;
var
  LConfig: TRickDialogProConfig;
  LTheme: IRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
begin
  LConfig := TRickDialogProConfig.Default;
  LConfig.Title := 'RuntimeForm Test';

  LTheme := TRickDialogProDefaultTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(
    nil,
    LConfig,
    LTheme
  );
  try
    Assert.IsTrue(
      Assigned(LForm),
      'A RuntimeForm nao foi criada.'
    );

    Assert.AreEqual(
      'RuntimeForm Test',
      LForm.Caption,
      'A RuntimeForm nao recebeu o titulo da configuracao.'
    );

    Assert.IsTrue(
      LForm.Transparency,
      'A RuntimeForm deveria manter Transparency=True.'
    );
  finally
    LForm.Free;
  end;
end;

procedure TEnvironmentTests.RuntimeForm_ControlsCanBeLocated;
var
  LConfig: TRickDialogProConfig;
  LTheme: IRickDialogProTheme;
  LForm: TRickDialogProRuntimeForm;
  LTitle: TLabel;
  LMessage: TLabel;
  LPrimaryButton: TRectangle;
begin
  LConfig := TRickDialogProConfig.Information(
    'Titulo de Teste',
    'Mensagem de Teste',
    'Confirmar'
  );

  LTheme := TRickDialogProDefaultTheme.New;

  LForm := TRickDialogProRuntimeForm.Create(
    nil,
    LConfig,
    LTheme
  );
  try
    LTitle := FindLabelByText(
      LForm,
      'Titulo de Teste'
    );

    Assert.IsTrue(
      Assigned(LTitle),
      'O label do titulo nao foi localizado.'
    );

    LMessage := FindLabelByText(
      LForm,
      'Mensagem de Teste'
    );

    Assert.IsTrue(
      Assigned(LMessage),
      'O label da mensagem nao foi localizado.'
    );

    LPrimaryButton := FindActionButtonByCaption(
      LForm,
      'Confirmar'
    );

    Assert.IsTrue(
      Assigned(LPrimaryButton),
      'O botao Primary nao foi localizado.'
    );

    Assert.IsTrue(
      LPrimaryButton.HitTest,
      'O botao Primary deveria aceitar interacao.'
    );
  finally
    LForm.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TEnvironmentTests);

end.
