{*******************************************************}
{   Project: RickDialogPro                              }
{   Objective: Green Example Visual Theme               }
{   Author: Ricardo R. Pereira                          }
{   Created: 14/09/2026                                 }
{                                                       }
{   Summary:                                            }
{     Implements IRickDialogProTheme for the source     }
{     example using the green palette without changing  }
{     the RickDialogPro framework or its default theme. }
{                                                       }
{   Copyright (c) 2026 Ricardo R. Pereira               }
{   All rights reserved.                                }
{                                                       }
{   EXCLUSIVE INTELLECTUAL PROPERTY.                    }
{   This source code was developed entirely on personal }
{   time and with personal resources, without any       }
{   employment or corporate relationship that could     }
{   claim rights over it.                               }
{                                                       }
{   Unauthorized copying, distribution, modification,   }
{   or use is strictly prohibited without prior written }
{   permission from the author.                         }
{                                                       }
{   The author reserves the right to revoke usage       }
{   permission at any time, for any reason, upon formal }
{   notification.                                       }
{                                                       }
{   Unauthorized use constitutes copyright infringement }
{   and is subject to applicable civil and criminal     }
{   penalties.                                          }
{*******************************************************}

unit RickDialogPro.Sample.Theme.Green;

interface

uses
  System.UITypes,

  Rick.Dialog.Pro;

type
  /// <summary>
  ///   Tema green utilizado exclusivamente pelo projeto de exemplo.
  /// </summary>
  /// <remarks>
  ///   A classe não possui estado mutável e implementa o mesmo contrato público
  ///   utilizado por qualquer tema customizado do RickDialogPro.
  /// </remarks>
  TRickDialogProSampleGreenTheme = class sealed(TInterfacedObject, IRickDialogProTheme)
  public
    /// <summary>Cria uma nova instância do tema green.</summary>
    class function New: IRickDialogProTheme;

    /// <summary>Retorna a cor de fundo da janela modal.</summary>
    function Background: TAlphaColor;

    /// <summary>Retorna a cor da superfície principal do card.</summary>
    function Surface: TAlphaColor;

    /// <summary>
    ///   Retorna a cor utilizada por superfícies visualmente elevadas.
    /// </summary>
    function SurfaceElevated: TAlphaColor;

    /// <summary>Retorna a cor da borda do card.</summary>
    function Border: TAlphaColor;

    /// <summary>Retorna a cor do texto principal.</summary>
    function TextPrimary: TAlphaColor;

    /// <summary>Retorna a cor do texto secundário.</summary>
    function TextSecondary: TAlphaColor;

    /// <summary>Retorna a cor semântica conforme o tipo do diálogo.</summary>
    function StatusColor(AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>Retorna o fundo translúcido do ícone.</summary>
    function IconBackground(AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>Retorna a cor do traço do ícone.</summary>
    function IconStroke(AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>Retorna a cor normal do botão principal.</summary>
    function PrimaryButtonBackground(AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>Retorna a cor de hover do botão principal.</summary>
    function PrimaryButtonHoverBackground(
      AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>Retorna a cor do texto do botão principal.</summary>
    function PrimaryButtonText(AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>Retorna a cor normal do botão secundário.</summary>
    function SecondaryButtonBackground: TAlphaColor;

    /// <summary>Retorna a cor de hover do botão secundário.</summary>
    function SecondaryButtonHoverBackground: TAlphaColor;

    /// <summary>Retorna a cor do texto do botão secundário.</summary>
    function SecondaryButtonText: TAlphaColor;
  end;

implementation

uses
  RickDialogPro.Sample.Theme.Green.Colors;

{ TRickDialogProSampleGreenTheme }

class function TRickDialogProSampleGreenTheme.New: IRickDialogProTheme;
begin
  Result := Self.Create;
end;

function TRickDialogProSampleGreenTheme.Background: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BACKGROUND;
end;

function TRickDialogProSampleGreenTheme.Surface: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_SURFACE;
end;

function TRickDialogProSampleGreenTheme.SurfaceElevated: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_SURFACE_ELEVATED;
end;

function TRickDialogProSampleGreenTheme.Border: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BORDER;
end;

function TRickDialogProSampleGreenTheme.TextPrimary: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_TEXT_PRIMARY;
end;

function TRickDialogProSampleGreenTheme.TextSecondary: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_TEXT_SECONDARY;
end;

function TRickDialogProSampleGreenTheme.StatusColor(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_STATUS_ERROR;

    TRickDialogProKind.Warning:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_STATUS_WARNING;

    TRickDialogProKind.Information:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_STATUS_INFORMATION;

    TRickDialogProKind.Success:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_STATUS_SUCCESS;
  else
    Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_ACCENT;
  end;
end;

function TRickDialogProSampleGreenTheme.IconBackground(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_ICON_BG_ERROR;

    TRickDialogProKind.Warning:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_ICON_BG_WARNING;

    TRickDialogProKind.Information:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_ICON_BG_INFORMATION;

    TRickDialogProKind.Success:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_ICON_BG_SUCCESS;
  else
    Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_ICON_BG_INFORMATION;
  end;
end;

function TRickDialogProSampleGreenTheme.IconStroke(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_ICON_STROKE_ERROR;

    TRickDialogProKind.Warning:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_ICON_STROKE_WARNING;

    TRickDialogProKind.Information:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_ICON_STROKE_INFORMATION;

    TRickDialogProKind.Success:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_ICON_STROKE_SUCCESS;
  else
    Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_ICON_STROKE_INFORMATION;
  end;
end;

function TRickDialogProSampleGreenTheme.PrimaryButtonBackground(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_ERROR_BG;

    TRickDialogProKind.Warning:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_WARNING_BG;

    TRickDialogProKind.Information:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_INFORMATION_BG;

    TRickDialogProKind.Success:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_SUCCESS_BG;
  else
    Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_INFORMATION_BG;
  end;
end;

function TRickDialogProSampleGreenTheme.PrimaryButtonHoverBackground(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_ERROR_HOVER_BG;

    TRickDialogProKind.Warning:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_WARNING_HOVER_BG;

    TRickDialogProKind.Information:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_INFORMATION_HOVER_BG;

    TRickDialogProKind.Success:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_SUCCESS_HOVER_BG;
  else
    Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_INFORMATION_HOVER_BG;
  end;
end;

function TRickDialogProSampleGreenTheme.PrimaryButtonText(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_ERROR_TEXT;

    TRickDialogProKind.Warning:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_WARNING_TEXT;

    TRickDialogProKind.Information:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_INFORMATION_TEXT;

    TRickDialogProKind.Success:
      Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_SUCCESS_TEXT;
  else
    Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_INFORMATION_TEXT;
  end;
end;

function TRickDialogProSampleGreenTheme.SecondaryButtonBackground: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_SECONDARY_BG;
end;

function TRickDialogProSampleGreenTheme.SecondaryButtonHoverBackground: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_SECONDARY_HOVER_BG;
end;

function TRickDialogProSampleGreenTheme.SecondaryButtonText: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_SAMPLE_GREEN_BUTTON_SECONDARY_TEXT;
end;

end.
