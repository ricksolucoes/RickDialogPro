{*******************************************************}
{   Project: RickDialogPro                              }
{   Objective: Default Visual Color Palette             }
{   Author: Ricardo R. Pereira                          }
{   Created: 11/09/2026                                 }
{                                                       }
{   Summary:                                            }
{    Defines the default color palette used by          }
{    RickDialogPro. The unit contains constants only and}
{    does not contain rendering or business rules.      }
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

unit Rick.Dialog.Pro.Theme.Default.Colors;

interface

uses
  System.UITypes;

const
  /// <summary>Cor de fundo da janela modal.</summary>
  _RICK_DIALOG_PRO_BACKGROUND                   = TAlphaColor($FF0F172A);

  /// <summary>Cor da superfície principal do card.</summary>
  _RICK_DIALOG_PRO_SURFACE                      = TAlphaColor($FF1E293B);

  /// <summary>Cor de superfície elevada usada em estados de interação.</summary>
  _RICK_DIALOG_PRO_SURFACE_ELEVATED             = TAlphaColor($FF273449);

  /// <summary>Cor padrão da borda do card.</summary>
  _RICK_DIALOG_PRO_BORDER                       = TAlphaColor($FF334155);

  /// <summary>Cor totalmente transparente utilizada por elementos ghost.</summary>
  _RICK_DIALOG_PRO_TRANSPARENT                  = TAlphaColor($00000000);

  /// <summary>Cor do texto principal.</summary>
  _RICK_DIALOG_PRO_TEXT_PRIMARY                 = TAlphaColor($FFF1F5F9);

  /// <summary>Cor do texto secundário.</summary>
  _RICK_DIALOG_PRO_TEXT_SECONDARY               = TAlphaColor($FF94A3B8);

  /// <summary>Cor de accent padrão do Design System.</summary>
  _RICK_DIALOG_PRO_ACCENT                       = TAlphaColor($FF3B82F6);

  /// <summary>Cor inicial do gradiente padrão.</summary>
  _RICK_DIALOG_PRO_GRADIENT_START               = TAlphaColor($FF0F172A);

  /// <summary>Cor final do gradiente padrão.</summary>
  _RICK_DIALOG_PRO_GRADIENT_END                 = TAlphaColor($FF1E293B);

  /// <summary>Cor semântica de erro.</summary>
  _RICK_DIALOG_PRO_STATUS_ERROR                 = TAlphaColor($FFEF4444);

  /// <summary>Cor semântica de atenção.</summary>
  _RICK_DIALOG_PRO_STATUS_WARNING               = TAlphaColor($FFF59E0B);

  /// <summary>Cor semântica de informação.</summary>
  _RICK_DIALOG_PRO_STATUS_INFORMATION           = TAlphaColor($FF3B82F6);

  /// <summary>Cor semântica de sucesso.</summary>
  _RICK_DIALOG_PRO_STATUS_SUCCESS               = TAlphaColor($FF22C55E);

  /// <summary>Fundo translúcido de badge informativo.</summary>
  _RICK_DIALOG_PRO_BADGE_INFORMATION_BG         = TAlphaColor($263B82F6);

  /// <summary>Texto de badge informativo.</summary>
  _RICK_DIALOG_PRO_BADGE_INFORMATION_TEXT       = TAlphaColor($FF60A5FA);

  /// <summary>Fundo translúcido de badge de atenção.</summary>
  _RICK_DIALOG_PRO_BADGE_WARNING_BG             = TAlphaColor($26F59E0B);

  /// <summary>Fundo translúcido de badge neutro.</summary>
  _RICK_DIALOG_PRO_BADGE_NEUTRAL_BG             = TAlphaColor($2664748B);

  /// <summary>Texto de badge neutro.</summary>
  _RICK_DIALOG_PRO_BADGE_NEUTRAL_TEXT           = TAlphaColor($FF94A3B8);

  /// <summary>Cor da barra superior para erro.</summary>
  _RICK_DIALOG_PRO_BORDER_ERROR                 = _RICK_DIALOG_PRO_STATUS_ERROR;

  /// <summary>Cor da barra superior para atenção.</summary>
  _RICK_DIALOG_PRO_BORDER_WARNING               = _RICK_DIALOG_PRO_STATUS_WARNING;

  /// <summary>Cor da barra superior para informação.</summary>
  _RICK_DIALOG_PRO_BORDER_INFORMATION           = _RICK_DIALOG_PRO_STATUS_INFORMATION;

  /// <summary>Cor da barra superior para sucesso.</summary>
  _RICK_DIALOG_PRO_BORDER_SUCCESS               = _RICK_DIALOG_PRO_STATUS_SUCCESS;

  /// <summary>Fundo translúcido do ícone de erro.</summary>
  _RICK_DIALOG_PRO_ICON_BG_ERROR                = TAlphaColor($26EF4444);

  /// <summary>Fundo translúcido do ícone de atenção.</summary>
  _RICK_DIALOG_PRO_ICON_BG_WARNING              = TAlphaColor($26F59E0B);

  /// <summary>Fundo translúcido do ícone de informação.</summary>
  _RICK_DIALOG_PRO_ICON_BG_INFORMATION          = TAlphaColor($263B82F6);

  /// <summary>Fundo translúcido do ícone de sucesso.</summary>
  _RICK_DIALOG_PRO_ICON_BG_SUCCESS              = TAlphaColor($2622C55E);

  /// <summary>Cor do traço vetorial do ícone de erro.</summary>
  _RICK_DIALOG_PRO_ICON_STROKE_ERROR            = TAlphaColor($FFF87171);

  /// <summary>Cor do traço vetorial do ícone de atenção.</summary>
  _RICK_DIALOG_PRO_ICON_STROKE_WARNING          = TAlphaColor($FFFBBF24);

  /// <summary>Cor do traço vetorial do ícone de informação.</summary>
  _RICK_DIALOG_PRO_ICON_STROKE_INFORMATION      = TAlphaColor($FF60A5FA);

  /// <summary>Cor do traço vetorial do ícone de sucesso.</summary>
  _RICK_DIALOG_PRO_ICON_STROKE_SUCCESS          = TAlphaColor($FF4ADE80);

  /// <summary>Fundo normal do botão principal de erro.</summary>
  _RICK_DIALOG_PRO_BUTTON_ERROR_BG              = TAlphaColor($FFEF4444);

  /// <summary>Fundo de hover do botão principal de erro.</summary>
  _RICK_DIALOG_PRO_BUTTON_ERROR_HOVER_BG        = TAlphaColor($FFDC2626);

  /// <summary>Texto do botão principal de erro.</summary>
  _RICK_DIALOG_PRO_BUTTON_ERROR_TEXT            = TAlphaColor($FFFFFFFF);

  /// <summary>Fundo normal do botão principal de atenção.</summary>
  _RICK_DIALOG_PRO_BUTTON_WARNING_BG            = TAlphaColor($FFF59E0B);

  /// <summary>Fundo de hover do botão principal de atenção.</summary>
  _RICK_DIALOG_PRO_BUTTON_WARNING_HOVER_BG      = TAlphaColor($FFD97706);

  /// <summary>Texto do botão principal de atenção.</summary>
  _RICK_DIALOG_PRO_BUTTON_WARNING_TEXT          = TAlphaColor($FF1E293B);

  /// <summary>Fundo normal do botão principal de informação.</summary>
  _RICK_DIALOG_PRO_BUTTON_INFORMATION_BG        = TAlphaColor($FF3B82F6);

  /// <summary>Fundo de hover do botão principal de informação.</summary>
  _RICK_DIALOG_PRO_BUTTON_INFORMATION_HOVER_BG  = TAlphaColor($FF2563EB);

  /// <summary>Texto do botão principal de informação.</summary>
  _RICK_DIALOG_PRO_BUTTON_INFORMATION_TEXT      = TAlphaColor($FFFFFFFF);

  /// <summary>Fundo normal do botão principal de sucesso.</summary>
  _RICK_DIALOG_PRO_BUTTON_SUCCESS_BG            = TAlphaColor($FF22C55E);

  /// <summary>Fundo de hover do botão principal de sucesso.</summary>
  _RICK_DIALOG_PRO_BUTTON_SUCCESS_HOVER_BG      = TAlphaColor($FF16A34A);

  /// <summary>Texto do botão principal de sucesso.</summary>
  _RICK_DIALOG_PRO_BUTTON_SUCCESS_TEXT          = TAlphaColor($FF0F172A);

  /// <summary>Fundo normal transparente do botão secundário.</summary>
  _RICK_DIALOG_PRO_BUTTON_SECONDARY_BG          = _RICK_DIALOG_PRO_TRANSPARENT;

  /// <summary>Fundo de hover do botão secundário.</summary>
  _RICK_DIALOG_PRO_BUTTON_SECONDARY_HOVER_BG    = _RICK_DIALOG_PRO_SURFACE_ELEVATED;

  /// <summary>Texto do botão secundário.</summary>
  _RICK_DIALOG_PRO_BUTTON_SECONDARY_TEXT        = TAlphaColor($FF94A3B8);

implementation

end.
