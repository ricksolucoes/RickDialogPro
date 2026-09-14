unit Rick.Dialog.Pro.Tests.Types;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TConfigTests = class
  public
    [Test]
    procedure Default_ReturnsExpectedValues;

    [Test]
    procedure Error_ReturnsExpectedValues;

    [Test]
    procedure Warning_ReturnsExpectedValues;

    [Test]
    procedure Information_ReturnsExpectedValues;

    [Test]
    procedure Success_ReturnsExpectedValues;

    [Test]
    procedure SecondaryCaption_BlankAfterTrim_DisablesSecondary;

    [Test]
    procedure SecondaryCaption_WithText_EnablesSecondary;
  end;

implementation

uses
  Rick.Dialog.Pro.Types;

procedure TConfigTests.Default_ReturnsExpectedValues;
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Default;

  Assert.AreEqual(
    TRickDialogProKind.Information,
    LConfig.Kind
  );

  Assert.AreEqual('', LConfig.Title);
  Assert.AreEqual('', LConfig.MessageText);
  Assert.AreEqual('Entendi', LConfig.PrimaryCaption);
  Assert.AreEqual('', LConfig.SecondaryCaption);

  Assert.IsFalse(LConfig.ShowSecondary);
  Assert.IsFalse(LConfig.UseBackground);
end;

procedure TConfigTests.Error_ReturnsExpectedValues;
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Error(
    'Erro',
    'Mensagem de erro'
  );

  Assert.AreEqual(
    TRickDialogProKind.Error,
    LConfig.Kind
  );

  Assert.AreEqual('Erro', LConfig.Title);
  Assert.AreEqual('Mensagem de erro', LConfig.MessageText);
  Assert.AreEqual('Fechar', LConfig.PrimaryCaption);
  Assert.AreEqual('', LConfig.SecondaryCaption);

  Assert.IsFalse(LConfig.ShowSecondary);
  Assert.IsFalse(LConfig.UseBackground);
end;

procedure TConfigTests.Warning_ReturnsExpectedValues;
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Warning(
    'Atenção',
    'Mensagem de atenção'
  );

  Assert.AreEqual(
    TRickDialogProKind.Warning,
    LConfig.Kind
  );

  Assert.AreEqual('Atenção', LConfig.Title);
  Assert.AreEqual('Mensagem de atenção', LConfig.MessageText);
  Assert.AreEqual('Entendi', LConfig.PrimaryCaption);
  Assert.AreEqual('', LConfig.SecondaryCaption);

  Assert.IsFalse(LConfig.ShowSecondary);
  Assert.IsFalse(LConfig.UseBackground);
end;

procedure TConfigTests.Information_ReturnsExpectedValues;
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Information(
    'Informação',
    'Mensagem informativa'
  );

  Assert.AreEqual(
    TRickDialogProKind.Information,
    LConfig.Kind
  );

  Assert.AreEqual('Informação', LConfig.Title);
  Assert.AreEqual('Mensagem informativa', LConfig.MessageText);
  Assert.AreEqual('Entendi', LConfig.PrimaryCaption);
  Assert.AreEqual('', LConfig.SecondaryCaption);

  Assert.IsFalse(LConfig.ShowSecondary);
  Assert.IsFalse(LConfig.UseBackground);
end;

procedure TConfigTests.Success_ReturnsExpectedValues;
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Success(
    'Sucesso',
    'Mensagem de sucesso'
  );

  Assert.AreEqual(
    TRickDialogProKind.Success,
    LConfig.Kind
  );

  Assert.AreEqual('Sucesso', LConfig.Title);
  Assert.AreEqual('Mensagem de sucesso', LConfig.MessageText);
  Assert.AreEqual('Concluir', LConfig.PrimaryCaption);
  Assert.AreEqual('', LConfig.SecondaryCaption);

  Assert.IsFalse(LConfig.ShowSecondary);
  Assert.IsFalse(LConfig.UseBackground);
end;

procedure TConfigTests.SecondaryCaption_BlankAfterTrim_DisablesSecondary;
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Warning(
    'Confirmação',
    'Deseja continuar?',
    'Continuar',
    '   '
  );

  Assert.AreEqual('   ', LConfig.SecondaryCaption);

  Assert.IsFalse(
    LConfig.ShowSecondary,
    'ShowSecondary deveria ser False para caption contendo apenas espaços.'
  );
end;

procedure TConfigTests.SecondaryCaption_WithText_EnablesSecondary;
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Warning(
    'Confirmação',
    'Deseja continuar?',
    'Continuar',
    'Cancelar'
  );

  Assert.AreEqual('Cancelar', LConfig.SecondaryCaption);

  Assert.IsTrue(
    LConfig.ShowSecondary,
    'ShowSecondary deveria ser True quando existe caption secundária.'
  );

  Assert.IsFalse(
    LConfig.UseBackground,
    'Os builders devem preservar UseBackground=False.'
  );
end;

initialization
  TDUnitX.RegisterTestFixture(TConfigTests);

end.
