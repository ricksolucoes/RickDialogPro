{*******************************************************}
{   Project: RickDialogPro                              }
{   Objective: Green Example Theme Color Palette        }
{   Author: Ricardo R. Pereira                          }
{   Created: 14/09/2026                                 }
{                                                       }
{   Summary:                                            }
{     Defines the green palette used by the source      }
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

unit RickDialogPro.Source.Theme.Green.Colors;

interface

uses
  System.UITypes;

const
  /// <summary>Cor de fundo da janela modal.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BACKGROUND                   = TAlphaColor($FF052E16);

  /// <summary>Cor da superfície principal do card.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_SURFACE                      = TAlphaColor($FF064E3B);

  /// <summary>Cor de superfície elevada usada em estados de interação.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_SURFACE_ELEVATED             = TAlphaColor($FF065F46);

  /// <summary>Cor padrão da borda do card.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BORDER                       = TAlphaColor($FF047857);

  /// <summary>Cor totalmente transparente utilizada por elementos ghost.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_TRANSPARENT                  = TAlphaColor($00000000);

  /// <summary>Cor do texto principal.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_TEXT_PRIMARY                 = TAlphaColor($FFECFDF5);

  /// <summary>Cor do texto secundário.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_TEXT_SECONDARY               = TAlphaColor($FFA7F3D0);

  /// <summary>Cor de accent do tema.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_ACCENT                       = TAlphaColor($FF10B981);

  /// <summary>Cor semântica de erro.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_STATUS_ERROR                 = TAlphaColor($FFF87171);

  /// <summary>Cor semântica de atenção.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_STATUS_WARNING               = TAlphaColor($FFFBBF24);

  /// <summary>Cor semântica de informação.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_STATUS_INFORMATION           = TAlphaColor($FF60A5FA);

  /// <summary>Cor semântica de sucesso.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_STATUS_SUCCESS               = TAlphaColor($FF34D399);

  /// <summary>Fundo translúcido do ícone de erro.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_ICON_BG_ERROR                = TAlphaColor($26EF4444);

  /// <summary>Fundo translúcido do ícone de atenção.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_ICON_BG_WARNING              = TAlphaColor($26F59E0B);

  /// <summary>Fundo translúcido do ícone de informação.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_ICON_BG_INFORMATION          = TAlphaColor($263B82F6);

  /// <summary>Fundo translúcido do ícone de sucesso.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_ICON_BG_SUCCESS              = TAlphaColor($2634D399);

  /// <summary>Cor do traço vetorial do ícone de erro.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_ICON_STROKE_ERROR            = TAlphaColor($FFFCA5A5);

  /// <summary>Cor do traço vetorial do ícone de atenção.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_ICON_STROKE_WARNING          = TAlphaColor($FFFDE68A);

  /// <summary>Cor do traço vetorial do ícone de informação.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_ICON_STROKE_INFORMATION      = TAlphaColor($FF93C5FD);

  /// <summary>Cor do traço vetorial do ícone de sucesso.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_ICON_STROKE_SUCCESS          = TAlphaColor($FF6EE7B7);

  /// <summary>Fundo normal do botão principal de erro.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_ERROR_BG              = TAlphaColor($FFDC2626);

  /// <summary>Fundo de hover do botão principal de erro.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_ERROR_HOVER_BG        = TAlphaColor($FFB91C1C);

  /// <summary>Texto do botão principal de erro.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_ERROR_TEXT            = TAlphaColor($FFFFFFFF);

  /// <summary>Fundo normal do botão principal de atenção.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_WARNING_BG            = TAlphaColor($FFF59E0B);

  /// <summary>Fundo de hover do botão principal de atenção.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_WARNING_HOVER_BG      = TAlphaColor($FFD97706);

  /// <summary>Texto do botão principal de atenção.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_WARNING_TEXT          = TAlphaColor($FF1E293B);

  /// <summary>Fundo normal do botão principal de informação.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_INFORMATION_BG        = TAlphaColor($FF2563EB);

  /// <summary>Fundo de hover do botão principal de informação.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_INFORMATION_HOVER_BG  = TAlphaColor($FF1D4ED8);

  /// <summary>Texto do botão principal de informação.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_INFORMATION_TEXT      = TAlphaColor($FFFFFFFF);

  /// <summary>Fundo normal do botão principal de sucesso.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_SUCCESS_BG            = TAlphaColor($FF10B981);

  /// <summary>Fundo de hover do botão principal de sucesso.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_SUCCESS_HOVER_BG      = TAlphaColor($FF059669);

  /// <summary>Texto do botão principal de sucesso.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_SUCCESS_TEXT          = TAlphaColor($FF052E16);

  /// <summary>Fundo normal transparente do botão secundário.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_SECONDARY_BG          = _RICK_DIALOG_PRO_SOURCE_GREEN_TRANSPARENT;

  /// <summary>Fundo de hover do botão secundário.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_SECONDARY_HOVER_BG    = _RICK_DIALOG_PRO_SOURCE_GREEN_SURFACE_ELEVATED;

  /// <summary>Texto do botão secundário.</summary>
  _RICK_DIALOG_PRO_SOURCE_GREEN_BUTTON_SECONDARY_TEXT        = TAlphaColor($FFA7F3D0);

implementation

end.
