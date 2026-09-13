{*******************************************************}
{   Project: RickDialogPro                              }
{   Objective: Default Visual Theme                     }
{   Author: Ricardo R. Pereira                          }
{   Created: 11/09/2026                                 }
{                                                       }
{   Summary:                                            }
{     Implements IRickDialogProTheme by mapping each    }
{     semantic dialog kind to the colors declared by    }
{     Rick.Dialog.Pro.Theme.Default.Colors.             }
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

unit Rick.Dialog.Pro.Theme.Default;

interface

uses
  System.UITypes,

  Rick.Dialog.Pro.Types,
  Rick.Dialog.Pro.Theme.Interf;

type
  /// <summary>
  ///   Implementação padrão de <see cref="IRickDialogProTheme"/>.
  /// </summary>
  /// <remarks>
  ///   A classe não possui estado mutável. Cada método retorna a cor
  ///   correspondente ao elemento visual solicitado.
  /// </remarks>
  TRickDialogProDefaultTheme = class sealed(TInterfacedObject, IRickDialogProTheme)
  public
    /// <summary>
    ///   Cria uma nova instância do tema padrão.
    /// </summary>
    /// <returns>
    ///   Interface de tema pronta para ser utilizada pelo renderer.
    /// </returns>
    class function New: IRickDialogProTheme;

    /// <summary>Retorna a cor de fundo da janela modal.</summary>
    function Background: TAlphaColor;

    /// <summary>
    ///   Retorna a cor utilizada por superfícies visualmente elevadas,
    ///   como balões de texto e elementos sobrepostos.
    /// </summary>
    function SurfaceElevated: TAlphaColor;

    /// <summary>Retorna a cor da superfície principal do card.</summary>
    function Surface: TAlphaColor;

    /// <summary>Retorna a cor da borda do card.</summary>
    function Border: TAlphaColor;

    /// <summary>Retorna a cor do texto principal.</summary>
    function TextPrimary: TAlphaColor;

    /// <summary>Retorna a cor do texto secundário.</summary>
    function TextSecondary: TAlphaColor;

    /// <summary>
    ///   Retorna a cor da barra superior conforme o tipo do diálogo.
    /// </summary>
    /// <param name="AKind">Tipo semântico do diálogo.</param>
    function StatusColor(AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>
    ///   Retorna o fundo translúcido do ícone conforme o tipo do diálogo.
    /// </summary>
    /// <param name="AKind">Tipo semântico do diálogo.</param>
    function IconBackground(AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>
    ///   Retorna a cor do traço do ícone conforme o tipo do diálogo.
    /// </summary>
    /// <param name="AKind">Tipo semântico do diálogo.</param>
    function IconStroke(AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>
    ///   Retorna a cor normal do botão principal.
    /// </summary>
    /// <param name="AKind">Tipo semântico do diálogo.</param>
    function PrimaryButtonBackground(AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>
    ///   Retorna a cor de hover do botão principal.
    /// </summary>
    /// <param name="AKind">Tipo semântico do diálogo.</param>
    function PrimaryButtonHoverBackground(
      AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>
    ///   Retorna a cor do texto do botão principal.
    /// </summary>
    /// <param name="AKind">Tipo semântico do diálogo.</param>
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
  Rick.Dialog.Pro.Theme.Default.Colors;

{ TRickDialogProDefaultTheme }

class function TRickDialogProDefaultTheme.New: IRickDialogProTheme;
begin
  Result := Self.Create;
end;

function TRickDialogProDefaultTheme.Background: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_BACKGROUND;
end;

function TRickDialogProDefaultTheme.Surface: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_SURFACE;
end;

function TRickDialogProDefaultTheme.SurfaceElevated: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_SURFACE_ELEVATED;
end;

function TRickDialogProDefaultTheme.Border: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_BORDER;
end;

function TRickDialogProDefaultTheme.TextPrimary: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_TEXT_PRIMARY;
end;

function TRickDialogProDefaultTheme.TextSecondary: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_TEXT_SECONDARY;
end;

function TRickDialogProDefaultTheme.StatusColor(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := _RICK_DIALOG_PRO_BORDER_ERROR;

    TRickDialogProKind.Warning:
      Result := _RICK_DIALOG_PRO_BORDER_WARNING;

    TRickDialogProKind.Information:
      Result := _RICK_DIALOG_PRO_BORDER_INFORMATION;

    TRickDialogProKind.Success:
      Result := _RICK_DIALOG_PRO_BORDER_SUCCESS;
  else
    Result := _RICK_DIALOG_PRO_ACCENT;
  end;
end;

function TRickDialogProDefaultTheme.IconBackground(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := _RICK_DIALOG_PRO_ICON_BG_ERROR;

    TRickDialogProKind.Warning:
      Result := _RICK_DIALOG_PRO_ICON_BG_WARNING;

    TRickDialogProKind.Information:
      Result := _RICK_DIALOG_PRO_ICON_BG_INFORMATION;

    TRickDialogProKind.Success:
      Result := _RICK_DIALOG_PRO_ICON_BG_SUCCESS;
  else
    Result := _RICK_DIALOG_PRO_ICON_BG_INFORMATION;
  end;
end;

function TRickDialogProDefaultTheme.IconStroke(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := _RICK_DIALOG_PRO_ICON_STROKE_ERROR;

    TRickDialogProKind.Warning:
      Result := _RICK_DIALOG_PRO_ICON_STROKE_WARNING;

    TRickDialogProKind.Information:
      Result := _RICK_DIALOG_PRO_ICON_STROKE_INFORMATION;

    TRickDialogProKind.Success:
      Result := _RICK_DIALOG_PRO_ICON_STROKE_SUCCESS;
  else
    Result := _RICK_DIALOG_PRO_ICON_STROKE_INFORMATION;
  end;
end;

function TRickDialogProDefaultTheme.PrimaryButtonBackground(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := _RICK_DIALOG_PRO_BUTTON_ERROR_BG;

    TRickDialogProKind.Warning:
      Result := _RICK_DIALOG_PRO_BUTTON_WARNING_BG;

    TRickDialogProKind.Information:
      Result := _RICK_DIALOG_PRO_BUTTON_INFORMATION_BG;

    TRickDialogProKind.Success:
      Result := _RICK_DIALOG_PRO_BUTTON_SUCCESS_BG;
  else
    Result := _RICK_DIALOG_PRO_BUTTON_INFORMATION_BG;
  end;
end;

function TRickDialogProDefaultTheme.PrimaryButtonHoverBackground(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := _RICK_DIALOG_PRO_BUTTON_ERROR_HOVER_BG;

    TRickDialogProKind.Warning:
      Result := _RICK_DIALOG_PRO_BUTTON_WARNING_HOVER_BG;

    TRickDialogProKind.Information:
      Result := _RICK_DIALOG_PRO_BUTTON_INFORMATION_HOVER_BG;

    TRickDialogProKind.Success:
      Result := _RICK_DIALOG_PRO_BUTTON_SUCCESS_HOVER_BG;
  else
    Result := _RICK_DIALOG_PRO_BUTTON_INFORMATION_HOVER_BG;
  end;
end;

function TRickDialogProDefaultTheme.PrimaryButtonText(
  AKind: TRickDialogProKind): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := _RICK_DIALOG_PRO_BUTTON_ERROR_TEXT;

    TRickDialogProKind.Warning:
      Result := _RICK_DIALOG_PRO_BUTTON_WARNING_TEXT;

    TRickDialogProKind.Information:
      Result := _RICK_DIALOG_PRO_BUTTON_INFORMATION_TEXT;

    TRickDialogProKind.Success:
      Result := _RICK_DIALOG_PRO_BUTTON_SUCCESS_TEXT;
  else
    Result := _RICK_DIALOG_PRO_BUTTON_INFORMATION_TEXT;
  end;
end;

function TRickDialogProDefaultTheme.SecondaryButtonBackground: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_BUTTON_SECONDARY_BG;
end;

function TRickDialogProDefaultTheme.SecondaryButtonHoverBackground: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_BUTTON_SECONDARY_HOVER_BG;
end;

function TRickDialogProDefaultTheme.SecondaryButtonText: TAlphaColor;
begin
  Result := _RICK_DIALOG_PRO_BUTTON_SECONDARY_TEXT;
end;

end.
