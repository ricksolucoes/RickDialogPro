unit Rick.Dialog.Pro.Tests.Icons;

interface

uses
  DUnitX.TestFramework,
  Rick.Dialog.Pro.Types;

type
  [TestFixture]
  TIconsTests = class
  private
    procedure ValidateIcon(
      const AKind: TRickDialogProKind
    );
  public
    [Test]
    procedure Error_ReturnsValidIcon;

    [Test]
    procedure Warning_ReturnsValidIcon;

    [Test]
    procedure Information_ReturnsValidIcon;

    [Test]
    procedure Success_ReturnsValidIcon;

    [Test]
    procedure Kinds_ReturnDifferentPaths;
  end;

implementation

uses
  Rick.Dialog.Pro.Icons;

procedure TIconsTests.ValidateIcon(
  const AKind: TRickDialogProKind
);
var
  LIcon: TRickDialogProIconData;
begin
  LIcon := TRickDialogProIcons.Resolve(AKind);

  Assert.IsTrue(
    LIcon.PathData <> '',
    'PathData nao deveria estar vazio.'
  );

  Assert.IsTrue(
    LIcon.ViewBoxWidth > 0,
    'ViewBoxWidth deveria ser maior que zero.'
  );

  Assert.IsTrue(
    LIcon.ViewBoxHeight > 0,
    'ViewBoxHeight deveria ser maior que zero.'
  );
end;

procedure TIconsTests.Error_ReturnsValidIcon;
begin
  ValidateIcon(
    TRickDialogProKind.Error
  );
end;

procedure TIconsTests.Warning_ReturnsValidIcon;
begin
  ValidateIcon(
    TRickDialogProKind.Warning
  );
end;

procedure TIconsTests.Information_ReturnsValidIcon;
begin
  ValidateIcon(
    TRickDialogProKind.Information
  );
end;

procedure TIconsTests.Success_ReturnsValidIcon;
begin
  ValidateIcon(
    TRickDialogProKind.Success
  );
end;

procedure TIconsTests.Kinds_ReturnDifferentPaths;
var
  LError: TRickDialogProIconData;
  LWarning: TRickDialogProIconData;
  LInformation: TRickDialogProIconData;
  LSuccess: TRickDialogProIconData;
begin
  LError := TRickDialogProIcons.Resolve(
    TRickDialogProKind.Error
  );

  LWarning := TRickDialogProIcons.Resolve(
    TRickDialogProKind.Warning
  );

  LInformation := TRickDialogProIcons.Resolve(
    TRickDialogProKind.Information
  );

  LSuccess := TRickDialogProIcons.Resolve(
    TRickDialogProKind.Success
  );

  Assert.AreNotEqual(
    LError.PathData,
    LWarning.PathData
  );

  Assert.AreNotEqual(
    LError.PathData,
    LInformation.PathData
  );

  Assert.AreNotEqual(
    LError.PathData,
    LSuccess.PathData
  );

  Assert.AreNotEqual(
    LWarning.PathData,
    LInformation.PathData
  );

  Assert.AreNotEqual(
    LWarning.PathData,
    LSuccess.PathData
  );

  Assert.AreNotEqual(
    LInformation.PathData,
    LSuccess.PathData
  );
end;

initialization
  TDUnitX.RegisterTestFixture(TIconsTests);

end.
