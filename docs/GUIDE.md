# RickDialogPro — Usage Guide

This guide documents the public usage surface that is currently supported by the RickDialogPro source code.

> [!IMPORTANT]
> Consumer code should use the public `Rick.Dialog.Pro` unit. Units under `Rick.Dialog.Pro.Impl.*` are implementation details and are not required for normal consumption.

## 1. Public API

The public facade is exposed through:

```delphi
uses
  Rick.Dialog.Pro;
```

The facade makes the main public contracts and types available:

- `TRickDialogPro`
- `IRickDialogPro`
- `IRickDialogProTheme`
- `TRickDialogProKind`
- `TRickDialogProResult`
- `TRickDialogProConfig`

A dialog instance can be created with the default theme:

```delphi
var
  LDialog: IRickDialogPro;
begin
  LDialog := TRickDialogPro.New;
end;
```

Or with a custom theme that implements `IRickDialogProTheme`:

```delphi
LDialog := TRickDialogPro.New(LTheme);
```

## 2. Using the Current Source Layout

The current repository includes a FireMonkey example under `source/`.

When the framework is referenced directly from the current source layout, that example uses these Delphi Search Path directories:

```text
src
src\Impl
src\Theme
source\theme
```

These paths describe the current repository organization. They are not a statement about every possible future distribution mechanism.

## 3. Keeping a Dialog Instance

The example included in the repository keeps an `IRickDialogPro` reference in the form:

```delphi
private
  FDialog: IRickDialogPro;
```

and creates the instance when the form is initialized:

```delphi
procedure TPageMain.FormCreate(Sender: TObject);
begin
  FDialog := TRickDialogPro.New;
end;
```

The interface reference can then be reused for multiple dialog calls.

## 4. Information

**Verified behavior:** `Information` is part of the current `IRickDialogPro` contract. Its default primary caption is `Entendi`, and the secondary caption defaults to an empty string.

```delphi
var
  LResult: TRickDialogProResult;
begin
  LResult := FDialog.Information(
    'Information',
    'The data was updated.'
  );
end;
```

A custom primary caption can also be supplied:

```delphi
FDialog.Information(
  'Information',
  'The data was updated.',
  'OK'
);
```

## 5. Success

**Verified behavior:** `Success` is part of the current contract. Its default primary caption is `Concluir`.

```delphi
FDialog.Success(
  'Success',
  'The operation was completed.'
);
```

With a custom caption:

```delphi
FDialog.Success(
  'Success',
  'The operation was completed.',
  'Close'
);
```

## 6. Warning

**Verified behavior:** `Warning` is part of the current contract. Its default primary caption is `Entendi`.

```delphi
FDialog.Warning(
  'Attention',
  'Review the data before continuing.'
);
```

It can also expose a secondary action:

```delphi
FDialog.Warning(
  'Confirmation',
  'Do you want to continue?',
  'Continue',
  'Cancel'
);
```

## 7. Error

**Verified behavior:** `Error` is part of the current contract. Its default primary caption is `Fechar`.

```delphi
FDialog.Error(
  'Error',
  'The operation could not be completed.'
);
```

With custom captions:

```delphi
FDialog.Error(
  'Error',
  'The operation could not be completed.',
  'Retry',
  'Close'
);
```

## 8. Custom Action Captions

The semantic helper methods accept the following arguments:

```text
Title
MessageText
PrimaryCaption
SecondaryCaption
```

`PrimaryCaption` and `SecondaryCaption` allow the consuming application to define the text shown to the user.

Example:

```delphi
FDialog.Warning(
  'Delete item',
  'Do you want to delete the selected item?',
  'Delete',
  'Keep'
);
```

The captions describe presentation. The meaning of each returned action remains the responsibility of the consuming application.

## 9. Handling Results

The public result type is:

```delphi
TRickDialogProResult = (
  None,
  Primary,
  Secondary
);
```

### Primary and Secondary

**Verified behavior:** clicking the primary action records `Primary`; clicking the secondary action records `Secondary`.

```delphi
var
  LResult: TRickDialogProResult;
begin
  LResult := FDialog.Warning(
    'Confirmation',
    'Do you want to continue?',
    'Continue',
    'Cancel'
  );

  case LResult of
    TRickDialogProResult.Primary:
      begin
        { Application-defined primary action. }
      end;

    TRickDialogProResult.Secondary:
      begin
        { Application-defined secondary action. }
      end;

    TRickDialogProResult.None:
      begin
        { No Primary or Secondary action was recorded. }
      end;
  end;
end;
```

### None

**Verified behavior:** the runtime dialog initializes its result as `None`. The value is changed only when a recognized primary or secondary action is recorded, and `Execute` returns the current result after the modal interaction ends.

Therefore, the supported statement is:

> `None` means that no `Primary` or `Secondary` action was recorded before the modal execution ended.

The current code does **not** justify assigning a specific closing mechanism to `None`. This guide therefore does not claim, for example, that `None` specifically means Escape, window close, or any other particular action.

## 10. Business Rules Stay in the Application

RickDialogPro returns which action was selected. It does not execute application business rules.

Example:

```delphi
var
  LResult: TRickDialogProResult;
begin
  LResult := FDialog.Warning(
    'Delete record',
    'Do you want to delete this record?',
    'Delete',
    'Cancel'
  );

  case LResult of
    TRickDialogProResult.Primary:
      DeleteRecord;

    TRickDialogProResult.Secondary:
      Exit;
  end;
end;
```

In this example, `DeleteRecord` belongs to the consuming application. RickDialogPro only reports the selected action.

`Primary` does not universally mean "Yes", and `Secondary` does not universally mean "Cancel". Their business meaning depends on the captions and the consuming code.

## 11. Execute with TRickDialogProConfig

In addition to the four semantic helper methods, `IRickDialogPro` exposes:

```delphi
function Execute(
  const AConfig: TRickDialogProConfig
): TRickDialogProResult;
```

A configuration can be created with one of the existing builders:

```delphi
var
  LConfig: TRickDialogProConfig;
  LResult: TRickDialogProResult;
begin
  LConfig := TRickDialogProConfig.Warning(
    'Confirmation',
    'Do you want to continue?',
    'Continue',
    'Cancel'
  );

  LResult := FDialog.Execute(LConfig);
end;
```

This is useful when the application needs to prepare the configuration before showing the dialog.

## 12. Configuration Builders

`TRickDialogProConfig` currently provides these builders:

```delphi
TRickDialogProConfig.Error(...)
TRickDialogProConfig.Warning(...)
TRickDialogProConfig.Information(...)
TRickDialogProConfig.Success(...)
```

**Verified behavior:** each builder:

1. starts from `TRickDialogProConfig.Default`;
2. applies the requested semantic kind;
3. assigns the title, message and captions;
4. sets `ShowSecondary` according to whether the trimmed secondary caption is empty;
5. preserves `UseBackground` as `False`, as defined by `TRickDialogProConfig.Default`.

For example:

```delphi
LConfig := TRickDialogProConfig.Success(
  'Completed',
  'The operation finished successfully.',
  'Finish'
);
```

If the secondary caption is omitted or blank after trimming, the builder sets `ShowSecondary` to `False`.

## 13. Manual Configuration

Manual configuration is possible because the configuration record exposes its fields publicly.

The default configuration is:

| Field | Current default |
|---|---|
| `Kind` | `Information` |
| `Title` | empty |
| `MessageText` | empty |
| `PrimaryCaption` | `Entendi` |
| `SecondaryCaption` | empty |
| `ShowSecondary` | `False` |
| `UseBackground` | `False` |

Example with one action:

```delphi
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Default;

  LConfig.Kind := TRickDialogProKind.Information;
  LConfig.Title := 'Information';
  LConfig.MessageText := 'The process is ready.';
  LConfig.PrimaryCaption := 'OK';

  FDialog.Execute(LConfig);
end;
```

Example with a secondary action:

```delphi
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Default;

  LConfig.Kind := TRickDialogProKind.Warning;
  LConfig.Title := 'Confirmation';
  LConfig.MessageText := 'Do you want to continue?';
  LConfig.PrimaryCaption := 'Yes';
  LConfig.SecondaryCaption := 'No';
  LConfig.ShowSecondary := True;

  FDialog.Execute(LConfig);
end;
```

> [!IMPORTANT]
> **Verified behavior:** in the current runtime implementation, the secondary button is created only when `ShowSecondary` is `True` **and** `SecondaryCaption` is not empty after trimming.
>
> When configuration is built manually, set both values consistently. The existing configuration builders already calculate `ShowSecondary` from the secondary caption.

### Using the Theme Background

**Verified behavior:** `UseBackground` is `False` by default. When it remains disabled, the RuntimeForm keeps the current transparent `Fill.Color` behavior. When `UseBackground` is `True`, the RuntimeForm assigns `IRickDialogProTheme.Background` to the host form's `Fill.Color`.

```delphi
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Information(
    'Information',
    'The host form will use the Background provided by the theme.'
  );

  LConfig.UseBackground := True;

  FDialog.Execute(LConfig);
end;
```

The `Error`, `Warning`, `Information`, and `Success` helpers keep the default behavior because their builders start from `TRickDialogProConfig.Default`, where `UseBackground` is `False`. To enable the theme background through the current API, use `TRickDialogProConfig` and `Execute`.

> [!NOTE]
> The current code proves that, when enabled, `FTheme.Background` is assigned to the RuntimeForm `Fill.Color`. Because `Transparency` remains `True`, this guide does not claim additional visual effects beyond that assignment without specific visual validation.

## 14. Overflow Tooltips

The runtime checks the rendered text after the dialog interface has been built. When a label does not fit in the area reserved for it, RickDialogPro enables a hover tooltip with the complete text.

This behavior applies to the text elements that the runtime actually renders, including the title, wrapped message text, and action captions. Button captions are handled through the button hover itself, so the internal label does not intercept the click.

The tooltip uses the active theme as well: `SurfaceElevated` provides its surface color, `Border` provides the outline, and `TextPrimary` provides the tooltip text color. The tooltip is shown on hover only when the corresponding text is detected as overflowing and is hidden when the pointer leaves the element.

> [!NOTE]
> Overflow is determined from the actual text metrics used by FireMonkey. This guide intentionally does not define a fixed character count, pixel width, tooltip position, or line count because those details depend on text measurement and rendering.

## 15. Custom Themes

The public facade accepts a custom `IRickDialogProTheme`:

```delphi
FDialog := TRickDialogPro.New(LTheme);
```

A custom theme should implement the complete current interface.

### Illustrative example

> [!NOTE]
> The color values below are **illustrative only**. They demonstrate how to implement the public theme contract and inject the implementation into `TRickDialogPro.New`. They are not a required or recommended RickDialogPro palette.

```delphi
uses
  Rick.Dialog.Pro,
  System.UITypes;

type
  TMyDialogTheme = class(TInterfacedObject, IRickDialogProTheme)
  public
    function Background: TAlphaColor;
    function Surface: TAlphaColor;
    function SurfaceElevated: TAlphaColor;
    function Border: TAlphaColor;
    function TextPrimary: TAlphaColor;
    function TextSecondary: TAlphaColor;

    function StatusColor(
      AKind: TRickDialogProKind
    ): TAlphaColor;

    function IconBackground(
      AKind: TRickDialogProKind
    ): TAlphaColor;

    function IconStroke(
      AKind: TRickDialogProKind
    ): TAlphaColor;

    function PrimaryButtonBackground(
      AKind: TRickDialogProKind
    ): TAlphaColor;

    function PrimaryButtonHoverBackground(
      AKind: TRickDialogProKind
    ): TAlphaColor;

    function PrimaryButtonText(
      AKind: TRickDialogProKind
    ): TAlphaColor;

    function SecondaryButtonBackground: TAlphaColor;
    function SecondaryButtonHoverBackground: TAlphaColor;
    function SecondaryButtonText: TAlphaColor;
  end;

function TMyDialogTheme.Background: TAlphaColor;
begin
  Result := TAlphaColor($FF101418);
end;

function TMyDialogTheme.Surface: TAlphaColor;
begin
  Result := TAlphaColor($FF1C2228);
end;

function TMyDialogTheme.SurfaceElevated: TAlphaColor;
begin
  Result := TAlphaColor($FF252D35);
end;

function TMyDialogTheme.Border: TAlphaColor;
begin
  Result := TAlphaColor($FF3A4652);
end;

function TMyDialogTheme.TextPrimary: TAlphaColor;
begin
  Result := TAlphaColor($FFF5F7FA);
end;

function TMyDialogTheme.TextSecondary: TAlphaColor;
begin
  Result := TAlphaColor($FFB5C0CB);
end;

function TMyDialogTheme.StatusColor(
  AKind: TRickDialogProKind
): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := TAlphaColor($FFE05252);

    TRickDialogProKind.Warning:
      Result := TAlphaColor($FFE0A52B);

    TRickDialogProKind.Information:
      Result := TAlphaColor($FF4C9BE8);

    TRickDialogProKind.Success:
      Result := TAlphaColor($FF42A66B);
  else
    Result := TAlphaColor($FF4C9BE8);
  end;
end;

function TMyDialogTheme.IconBackground(
  AKind: TRickDialogProKind
): TAlphaColor;
begin
  Result := StatusColor(AKind);
end;

function TMyDialogTheme.IconStroke(
  AKind: TRickDialogProKind
): TAlphaColor;
begin
  Result := TAlphaColor($FFFFFFFF);
end;

function TMyDialogTheme.PrimaryButtonBackground(
  AKind: TRickDialogProKind
): TAlphaColor;
begin
  Result := StatusColor(AKind);
end;

function TMyDialogTheme.PrimaryButtonHoverBackground(
  AKind: TRickDialogProKind
): TAlphaColor;
begin
  Result := StatusColor(AKind);
end;

function TMyDialogTheme.PrimaryButtonText(
  AKind: TRickDialogProKind
): TAlphaColor;
begin
  Result := TAlphaColor($FFFFFFFF);
end;

function TMyDialogTheme.SecondaryButtonBackground: TAlphaColor;
begin
  Result := TAlphaColor($FF303942);
end;

function TMyDialogTheme.SecondaryButtonHoverBackground: TAlphaColor;
begin
  Result := TAlphaColor($FF3B4651);
end;

function TMyDialogTheme.SecondaryButtonText: TAlphaColor;
begin
  Result := TAlphaColor($FFF5F7FA);
end;
```

The theme can then be injected through the public facade:

```delphi
var
  LTheme: IRickDialogProTheme;
begin
  LTheme := TMyDialogTheme.Create;
  FDialog := TRickDialogPro.New(LTheme);
end;
```

The overload that receives a theme expects a valid `IRickDialogProTheme`. Passing `nil` does not fall back to the default theme; the current FMX implementation raises `EArgumentNilException`. Use `TRickDialogPro.New` without arguments when the default theme is desired.

### Background and `UseBackground`

`Background` is part of the current `IRickDialogProTheme` contract and must be implemented by a custom theme.

**Verified behavior:** the RuntimeForm queries `IRickDialogProTheme.Background` only when `TRickDialogProConfig.UseBackground` is `True`. When `UseBackground` remains `False`, the default behavior keeps the transparent `Fill.Color`.

The option is enabled through dialog configuration, not through an additional parameter on `Error`, `Warning`, `Information`, or `Success`.

> [!NOTE]
> In the current implementation, `Transparency` remains `True`. The documentation therefore strictly describes the assignment of `Background` to `Fill.Color` when enabled and does not presume a visual result beyond what the code validates.

### How the runtime consumes the theme

The theme contract maps directly to visual responsibilities in the current renderer. This is useful when creating a custom theme because each method has a concrete role instead of being a placeholder for future use.

| Theme method | Current runtime responsibility |
|---|---|
| `Background` | Host form `Fill.Color` when `UseBackground = True` |
| `Surface` | Main dialog card surface |
| `SurfaceElevated` | Overflow tooltip surface |
| `Border` | Main card border and overflow tooltip border |
| `TextPrimary` | Dialog title and overflow tooltip text |
| `TextSecondary` | Dialog message text |
| `StatusColor(AKind)` | Semantic line along the top edge of the card |
| `IconBackground(AKind)` | Background circle behind the semantic icon |
| `IconStroke(AKind)` | Vector icon color |
| `PrimaryButtonBackground(AKind)` | Primary button normal background |
| `PrimaryButtonHoverBackground(AKind)` | Primary button background while hovered |
| `PrimaryButtonText(AKind)` | Primary button text |
| `SecondaryButtonBackground` | Secondary button normal background |
| `SecondaryButtonHoverBackground` | Secondary button background while hovered |
| `SecondaryButtonText` | Secondary button text |

### Semantic kind and theme resolution

`TRickDialogProKind` is not only descriptive metadata. The current renderer passes the selected kind to the theme when resolving the top semantic line, icon colors, and primary button colors. This allows `Error`, `Warning`, `Information`, and `Success` to share the same layout while still presenting different semantic identities.

The secondary button methods do not receive `TRickDialogProKind` in the current public contract, so their appearance is theme-wide rather than kind-specific.

## 16. Repository Example

The FireMonkey example under `source/` demonstrates basic consumption and runtime selection among three themes:

- `Default`, which remains the initial theme and is created with `TRickDialogPro.New`;
- `Light`, implemented by `TRickDialogProSourceLightTheme`;
- `Green`, implemented by `TRickDialogProSourceGreenTheme`.

`Light` and `Green` belong to the example project. They demonstrate how a consumer can implement `IRickDialogProTheme` without changing the framework's default theme or public API.

The form keeps:

```delphi
FDialog: IRickDialogPro;
```

and starts with:

```delphi
FDialog := TRickDialogPro.New;
```

After selecting `Light` or `Green` and clicking `Apply`, the example recreates `FDialog` through the existing theme overload:

```delphi
FDialog := TRickDialogPro.New(TRickDialogProSourceLightTheme.New);
// or
FDialog := TRickDialogPro.New(TRickDialogProSourceGreenTheme.New);
```

Selecting `Default` and clicking `Apply` recreates the facade without a theme argument, returning to the framework default. The four semantic helpers continue to be invoked through the same public contract:

```delphi
FDialog.Error(...);
FDialog.Warning(...);
FDialog.Information(...);
FDialog.Success(...);
```

The example is not evidence that every API capability has dedicated UI coverage, and the example themes are not part of the framework's automated regression suite.

## 17. Quick API Reference

### TRickDialogPro

```delphi
class function New: IRickDialogPro; overload; static;

class function New(
  const ATheme: IRickDialogProTheme
): IRickDialogPro; overload; static;
```

### IRickDialogPro

```delphi
function Execute(
  const AConfig: TRickDialogProConfig
): TRickDialogProResult;

function Error(
  const ATitle: string;
  const AMessageText: string;
  const APrimaryCaption: string = 'Fechar';
  const ASecondaryCaption: string = ''
): TRickDialogProResult;

function Warning(
  const ATitle: string;
  const AMessageText: string;
  const APrimaryCaption: string = 'Entendi';
  const ASecondaryCaption: string = ''
): TRickDialogProResult;

function Information(
  const ATitle: string;
  const AMessageText: string;
  const APrimaryCaption: string = 'Entendi';
  const ASecondaryCaption: string = ''
): TRickDialogProResult;

function Success(
  const ATitle: string;
  const AMessageText: string;
  const APrimaryCaption: string = 'Concluir';
  const ASecondaryCaption: string = ''
): TRickDialogProResult;
```

### TRickDialogProKind

```delphi
TRickDialogProKind = (
  Error,
  Warning,
  Information,
  Success
);
```

### TRickDialogProResult

```delphi
TRickDialogProResult = (
  None,
  Primary,
  Secondary
);
```

### TRickDialogProConfig

Public fields:

```delphi
Kind: TRickDialogProKind;
Title: string;
MessageText: string;
PrimaryCaption: string;
SecondaryCaption: string;
ShowSecondary: Boolean;
UseBackground: Boolean;
```

Available builders:

```delphi
TRickDialogProConfig.Default
TRickDialogProConfig.Error(...)
TRickDialogProConfig.Warning(...)
TRickDialogProConfig.Information(...)
TRickDialogProConfig.Success(...)
```

## 18. Automated Regression Tests

The repository includes a DUnitX project at `tests/RickDialogPro.Tests.dproj`, integrated into `RickDialog.groupproj`. The suite exercises the public configuration builders and icons, the default theme, the runtime form, background handling, semantic colors, primary and secondary buttons, hover behavior, overflow tooltips, modal results, and facade end-to-end flows.

The current source tree contains **48 `[Test]` declarations**. The console runner is configured to add an NUnit-compatible XML logger using `TDUnitX.Options.XMLOutputFile`, but the project package reviewed here does not contain a persisted DUnitX result artifact.

The test project currently enables **Win32** as its target platform. A current execution result for that target must therefore be recorded during the build/test quality gate before the stable release. This guide does not extend any validation claim to Win64, Android, iOS, or macOS.

These tests protect deterministic behavior. They should not be interpreted as pixel-perfect visual certification across platforms, fonts, DPI settings, or operating-system rendering differences.

## 19. Current Implementation Notes

The following distinctions are intentional in this guide:

- **Verified behavior** is stated directly when it is supported by the current code.
- **Illustrative examples** are identified explicitly when values are chosen only to demonstrate API usage.
- **Current implementation cautions** are stated explicitly when documentation must limit a claim to what the code actually proves.

Relevant current behavior:

- `TRickDialogProConfig.UseBackground` is `False` by default.
- When `UseBackground = True`, the RuntimeForm assigns `IRickDialogProTheme.Background` to `Fill.Color`.
- `Transparency` remains `True`; therefore the guide does not extrapolate this into unvalidated visual effects.
- `TRickDialogPro.New(ATheme)` requires a non-`nil` theme; it does not silently substitute the default theme.
- Overflow tooltips are enabled only when the runtime detects that the rendered text does not fit its available area.
- The source tree declares 48 DUnitX tests and the test project is configured for Win32; the reviewed project package does not include a persisted execution-result artifact.

Claims about other target platforms or visual rendering should be added only after those targets are actually validated.
