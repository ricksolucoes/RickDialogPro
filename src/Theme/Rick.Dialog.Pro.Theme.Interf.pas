{*******************************************************}
{   Project: RickDialogPro                              }
{   Objective: Visual Theme Contract                    }
{   Author: Ricardo R. Pereira                          }
{   Created: 11/09/2026                                 }
{                                                       }
{   Summary:                                            }
{     Declares the visual theme abstraction used by     }
{     the FireMonkey renderer to obtain colors without  }
{     coupling the renderer to a concrete palette.      }
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

unit Rick.Dialog.Pro.Theme.Interf;

interface

uses
  System.UITypes,

  Rick.Dialog.Pro.Types;

type
  /// <summary>
  ///   Contrato de identidade visual utilizado pelo RickDialogPro.
  /// </summary>
  /// <remarks>
  ///   Uma aplicação pode substituir integralmente o tema padrão criando uma
  ///   classe que implemente esta interface e fornecendo-a para
  ///   TRickDialogPro.New.
  /// </remarks>
  IRickDialogProTheme = interface(IInterface)
    ['{2138F434-D476-4E38-8DAB-B80BD9D47099}']

    /// <summary>Retorna a cor de fundo da janela modal.</summary>
    function Background: TAlphaColor;

    /// <summary>Retorna a cor da superfície principal do card.</summary>
    function Surface: TAlphaColor;

    /// <summary>
    ///   Retorna a cor utilizada por superfícies visualmente elevadas,
    ///   como balões de texto e elementos sobrepostos.
    /// </summary>
    function SurfaceElevated: TAlphaColor;

    /// <summary>Retorna a cor da borda do card.</summary>
    function Border: TAlphaColor;

    /// <summary>Retorna a cor utilizada no texto principal.</summary>
    function TextPrimary: TAlphaColor;

    /// <summary>Retorna a cor utilizada no texto secundário.</summary>
    function TextSecondary: TAlphaColor;

    /// <summary>
    ///   Retorna a cor semântica utilizada pela barra superior.
    /// </summary>
    /// <param name="AKind">Tipo semântico do diálogo.</param>
    function StatusColor(AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>
    ///   Retorna a cor translúcida do fundo do ícone.
    /// </summary>
    /// <param name="AKind">Tipo semântico do diálogo.</param>
    function IconBackground(AKind: TRickDialogProKind): TAlphaColor;

    /// <summary>
    ///   Retorna a cor utilizada no traço do ícone vetorial.
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

end.
