unit Rick.Dialog.Pro.Tests.FMX.Helpers;

interface

uses
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types;

function FindDirectRectangle(AParent: TFmxObject): TRectangle;
function FindDirectPath(AParent: TFmxObject): TPath;
function FindDirectCircle(AParent: TFmxObject): TCircle;

function FindLabelByText(AParent: TFmxObject; const AText: string): TLabel;

function FindDirectLabelByText(AParent: TFmxObject;
  const AText: string): TLabel;

function FindActionButtonByCaption(AParent: TFmxObject; const ACaption: string)
: TRectangle;

function FindPassiveRectangleWithDirectLabelText(AParent: TFmxObject;
  const AText: string): TRectangle;

implementation

function FindDirectRectangle(AParent: TFmxObject): TRectangle;
var
  I: Integer;
  LChild: TFmxObject;
begin
  Result := nil;

  if not Assigned(AParent) then
    Exit;

  for I := 0 to AParent.ChildrenCount - 1 do
  begin
    LChild := AParent.Children[I];

    if LChild is TRectangle then
      Exit(TRectangle(LChild));
  end;
end;

function FindDirectPath(AParent: TFmxObject): TPath;
var
  I: Integer;
  LChild: TFmxObject;
begin
  Result := nil;

  if not Assigned(AParent) then
    Exit;

  for I := 0 to AParent.ChildrenCount - 1 do
  begin
    LChild := AParent.Children[I];

    if LChild is TPath then
      Exit(TPath(LChild));
  end;
end;

function FindDirectCircle(AParent: TFmxObject): TCircle;
var
  I: Integer;
  LChild: TFmxObject;
begin
  Result := nil;

  if not Assigned(AParent) then
    Exit;

  for I := 0 to AParent.ChildrenCount - 1 do
  begin
    LChild := AParent.Children[I];

    if LChild is TCircle then
      Exit(TCircle(LChild));
  end;
end;

function FindLabelByText(AParent: TFmxObject; const AText: string): TLabel;
var
  I: Integer;
  LChild: TFmxObject;
begin
  Result := nil;

  if not Assigned(AParent) then
    Exit;

  for I := 0 to AParent.ChildrenCount - 1 do
  begin
    LChild := AParent.Children[I];

    if (LChild is TLabel) and (TLabel(LChild).Text = AText) then
      Exit(TLabel(LChild));

    Result := FindLabelByText(LChild, AText);

    if Assigned(Result) then
      Exit;
  end;
end;

function FindDirectLabelByText(AParent: TFmxObject;
  const AText: string): TLabel;
var
  I: Integer;
  LChild: TFmxObject;
begin
  Result := nil;

  if not Assigned(AParent) then
    Exit;

  for I := 0 to AParent.ChildrenCount - 1 do
  begin
    LChild := AParent.Children[I];

    if (LChild is TLabel) and (TLabel(LChild).Text = AText) then
      Exit(TLabel(LChild));
  end;
end;

function FindActionButtonByCaption(AParent: TFmxObject; const ACaption: string)
: TRectangle;
var
  I: Integer;
  LChild: TFmxObject;
  LLabel: TLabel;
begin
  Result := nil;

  if not Assigned(AParent) then
    Exit;

  for I := 0 to AParent.ChildrenCount - 1 do
  begin
    LChild := AParent.Children[I];

    if LChild is TRectangle then
    begin
      LLabel := FindDirectLabelByText(LChild, ACaption);

      if Assigned(LLabel) and TRectangle(LChild).HitTest then
        Exit(TRectangle(LChild));
    end;

    Result := FindActionButtonByCaption(LChild, ACaption);

    if Assigned(Result) then
      Exit;
  end;
end;

function FindPassiveRectangleWithDirectLabelText(AParent: TFmxObject;
  const AText: string): TRectangle;
var
  I: Integer;
  LChild: TFmxObject;
begin
  Result := nil;

  if not Assigned(AParent) then
    Exit;

  for I := 0 to AParent.ChildrenCount - 1 do
  begin
    LChild := AParent.Children[I];

    if (LChild is TRectangle) and (not TRectangle(LChild).HitTest) and
    Assigned(FindDirectLabelByText(LChild, AText)) then
      Exit(TRectangle(LChild));

    Result := FindPassiveRectangleWithDirectLabelText(LChild, AText);

    if Assigned(Result) then
      Exit;
  end;
end;

end.
