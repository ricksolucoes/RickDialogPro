{*******************************************************}
{   Project: RickDialogPro                              }
{   Objective: Light Example Theme Color Palette        }
{   Author: Ricardo R. Pereira                          }
{   Created: 14/09/2026                                 }
{                                                       }
{   Summary:                                            }
{     Defines the light palette used by the source      }
{     example. The unit contains constants only and     }
{     does not change framework behavior.               }
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

unit RickDialogPro.Source.Theme.Light.Colors;

interface

uses
  System.UITypes;

const
  /// <summary>Cor de fundo da janela modal.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BACKGROUND                   = TAlphaColor($FFF8FAFC);

  /// <summary>Cor da superfície principal do card.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_SURFACE                      = TAlphaColor($FFFFFFFF);

  /// <summary>Cor de superfície elevada usada em estados de interação.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_SURFACE_ELEVATED             = TAlphaColor($FFF1F5F9);

  /// <summary>Cor padrão da borda do card.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BORDER                       = TAlphaColor($FFCBD5E1);

  /// <summary>Cor totalmente transparente utilizada por elementos ghost.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_TRANSPARENT                  = TAlphaColor($00000000);

  /// <summary>Cor do texto principal.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_TEXT_PRIMARY                 = TAlphaColor($FF0F172A);

  /// <summary>Cor do texto secundário.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_TEXT_SECONDARY               = TAlphaColor($FF475569);

  /// <summary>Cor de accent do tema.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_ACCENT                       = TAlphaColor($FF2563EB);

  /// <summary>Cor semântica de erro.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_STATUS_ERROR                 = TAlphaColor($FFDC2626);

  /// <summary>Cor semântica de atenção.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_STATUS_WARNING               = TAlphaColor($FFD97706);

  /// <summary>Cor semântica de informação.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_STATUS_INFORMATION           = TAlphaColor($FF2563EB);

  /// <summary>Cor semântica de sucesso.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_STATUS_SUCCESS               = TAlphaColor($FF16A34A);

  /// <summary>Fundo translúcido do ícone de erro.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_ICON_BG_ERROR                = TAlphaColor($1ADC2626);

  /// <summary>Fundo translúcido do ícone de atenção.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_ICON_BG_WARNING              = TAlphaColor($1AD97706);

  /// <summary>Fundo translúcido do ícone de informação.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_ICON_BG_INFORMATION          = TAlphaColor($1A2563EB);

  /// <summary>Fundo translúcido do ícone de sucesso.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_ICON_BG_SUCCESS              = TAlphaColor($1A16A34A);

  /// <summary>Cor do traço vetorial do ícone de erro.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_ICON_STROKE_ERROR            = TAlphaColor($FFDC2626);

  /// <summary>Cor do traço vetorial do ícone de atenção.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_ICON_STROKE_WARNING          = TAlphaColor($FFD97706);

  /// <summary>Cor do traço vetorial do ícone de informação.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_ICON_STROKE_INFORMATION      = TAlphaColor($FF2563EB);

  /// <summary>Cor do traço vetorial do ícone de sucesso.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_ICON_STROKE_SUCCESS          = TAlphaColor($FF16A34A);

  /// <summary>Fundo normal do botão principal de erro.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_ERROR_BG              = TAlphaColor($FFDC2626);

  /// <summary>Fundo de hover do botão principal de erro.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_ERROR_HOVER_BG        = TAlphaColor($FFB91C1C);

  /// <summary>Texto do botão principal de erro.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_ERROR_TEXT            = TAlphaColor($FFFFFFFF);

  /// <summary>Fundo normal do botão principal de atenção.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_WARNING_BG            = TAlphaColor($FFF59E0B);

  /// <summary>Fundo de hover do botão principal de atenção.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_WARNING_HOVER_BG      = TAlphaColor($FFD97706);

  /// <summary>Texto do botão principal de atenção.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_WARNING_TEXT          = TAlphaColor($FF1E293B);

  /// <summary>Fundo normal do botão principal de informação.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_INFORMATION_BG        = TAlphaColor($FF2563EB);

  /// <summary>Fundo de hover do botão principal de informação.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_INFORMATION_HOVER_BG  = TAlphaColor($FF1D4ED8);

  /// <summary>Texto do botão principal de informação.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_INFORMATION_TEXT      = TAlphaColor($FFFFFFFF);

  /// <summary>Fundo normal do botão principal de sucesso.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_SUCCESS_BG            = TAlphaColor($FF16A34A);

  /// <summary>Fundo de hover do botão principal de sucesso.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_SUCCESS_HOVER_BG      = TAlphaColor($FF15803D);

  /// <summary>Texto do botão principal de sucesso.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_SUCCESS_TEXT          = TAlphaColor($FFFFFFFF);

  /// <summary>Fundo normal transparente do botão secundário.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_SECONDARY_BG          = _RICK_DIALOG_PRO_SOURCE_LIGHT_TRANSPARENT;

  /// <summary>Fundo de hover do botão secundário.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_SECONDARY_HOVER_BG    = _RICK_DIALOG_PRO_SOURCE_LIGHT_SURFACE_ELEVATED;

  /// <summary>Texto do botão secundário.</summary>
  _RICK_DIALOG_PRO_SOURCE_LIGHT_BUTTON_SECONDARY_TEXT        = TAlphaColor($FF475569);

implementation

end.
