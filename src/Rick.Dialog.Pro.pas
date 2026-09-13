{*******************************************************}
{   Project: RickDialogPro                              }
{   Objective: Public Framework Facade                  }
{   Author: Ricardo R. Pereira                          }
{   Created: 11/09/2026                                 }
{                                                       }
{   Summary:                                            }
{     Exposes the public RickDialogPro facade, aliases  }
{     the public contracts and types, and creates the   }
{     FireMonkey implementation with either the default }
{     theme or a custom IRickDialogProTheme.            }
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

unit Rick.Dialog.Pro;

interface

uses
  Rick.Dialog.Pro.Interf,
  Rick.Dialog.Pro.Theme.Interf,
  Rick.Dialog.Pro.Types;

type
  /// <summary>
  ///   Alias público para o contrato principal do framework.
  /// </summary>
  IRickDialogPro = Rick.Dialog.Pro.Interf.IRickDialogPro;

  /// <summary>
  ///   Alias público para o contrato de tema visual.
  /// </summary>
  IRickDialogProTheme = Rick.Dialog.Pro.Theme.Interf.IRickDialogProTheme;

  /// <summary>
  ///   Alias público para o tipo semântico do diálogo.
  /// </summary>
  TRickDialogProKind = Rick.Dialog.Pro.Types.TRickDialogProKind;

  /// <summary>
  ///   Alias público para o resultado retornado pelo diálogo.
  /// </summary>
  TRickDialogProResult = Rick.Dialog.Pro.Types.TRickDialogProResult;

  /// <summary>
  ///   Alias público para a configuração de conteúdo e ações.
  /// </summary>
  TRickDialogProConfig = Rick.Dialog.Pro.Types.TRickDialogProConfig;

  /// <summary>
  ///   Fachada pública de criação do RickDialogPro.
  /// </summary>
  /// <remarks>
  ///   A fachada evita que a aplicação consumidora conheça a implementação
  ///   concreta FireMonkey.
  /// </remarks>
  TRickDialogPro = class sealed
  public
    /// <summary>
    ///   Cria uma instância utilizando o tema padrão do framework.
    /// </summary>
    /// <returns>
    ///   Instância de <see cref="IRickDialogPro"/>.
    /// </returns>
    class function New: IRickDialogPro; overload; static;

    /// <summary>
    ///   Cria uma instância utilizando um tema customizado.
    /// </summary>
    /// <param name="ATheme">
    ///   Implementação de <see cref="IRickDialogProTheme"/> que fornecerá as
    ///   cores utilizadas pelo renderer.
    /// </param>
    /// <returns>
    ///   Instância de <see cref="IRickDialogPro"/>.
    /// </returns>
    /// <exception cref="EArgumentNilException">
    ///   Lançada pela implementação quando ATheme for nil.
    /// </exception>
    class function New(
      const ATheme: IRickDialogProTheme): IRickDialogPro; overload; static;
  end;

implementation

uses
  Rick.Dialog.Pro.Impl.FMX,
  Rick.Dialog.Pro.Theme.Default;

{ TRickDialogPro }

class function TRickDialogPro.New: IRickDialogPro;
begin
  Result := TRickDialogProFMX.New(TRickDialogProDefaultTheme.New);
end;

class function TRickDialogPro.New(
  const ATheme: IRickDialogProTheme): IRickDialogPro;
begin
  Result := TRickDialogProFMX.New(ATheme);
end;

end.
