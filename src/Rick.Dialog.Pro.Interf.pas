{*******************************************************}
{   Project: RickDialogPro                              }
{   Objective: Public Dialog Contract                   }
{   Author: Ricardo R. Pereira                          }
{   Created: 11/09/2026                                 }
{                                                       }
{   Summary:                                            }
{     Declares the public interface used to display     }
{     modal dialogs and return the action selected by   }
{     the user without executing application business   }
{     rules.                                            }
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

unit Rick.Dialog.Pro.Interf;

interface

uses
  Rick.Dialog.Pro.Types;

type
  /// <summary>
  ///   Contrato público para exibição de diálogos RickDialogPro.
  /// </summary>
  /// <remarks>
  ///   O contrato oferece um método genérico, através de Execute, e quatro
  ///   atalhos semânticos para erro, atenção, informação e sucesso.
  ///
  ///   Nenhum método executa regra de negócio da aplicação consumidora.
  /// </remarks>
  IRickDialogPro = interface(IInterface)
    ['{64AA592E-8C9B-4B4E-98B8-C61E79869FD9}']

    /// <summary>
    ///   Exibe um diálogo utilizando uma configuração completa.
    /// </summary>
    /// <param name="AConfig">
    ///   Conteúdo, tipo e ações do diálogo.
    /// </param>
    /// <returns>
    ///   A ação selecionada pelo usuário.
    /// </returns>
    function Execute(const AConfig: TRickDialogProConfig): TRickDialogProResult;

    /// <summary>
    ///   Exibe um diálogo com semântica de erro.
    /// </summary>
    /// <param name="ATitle">Título apresentado no diálogo.</param>
    /// <param name="AMessageText">Mensagem apresentada ao usuário.</param>
    /// <param name="APrimaryCaption">Texto da ação principal.</param>
    /// <param name="ASecondaryCaption">Texto opcional da ação secundária.</param>
    /// <returns>A ação selecionada pelo usuário.</returns>
    function Error(const ATitle: string; const AMessageText: string;
      const APrimaryCaption: string = 'Fechar';
      const ASecondaryCaption: string = ''): TRickDialogProResult;

    /// <summary>
    ///   Exibe um diálogo com semântica de atenção.
    /// </summary>
    /// <param name="ATitle">Título apresentado no diálogo.</param>
    /// <param name="AMessageText">Mensagem apresentada ao usuário.</param>
    /// <param name="APrimaryCaption">Texto da ação principal.</param>
    /// <param name="ASecondaryCaption">Texto opcional da ação secundária.</param>
    /// <returns>A ação selecionada pelo usuário.</returns>
    function Warning(const ATitle: string; const AMessageText: string;
      const APrimaryCaption: string = 'Entendi';
      const ASecondaryCaption: string = ''): TRickDialogProResult;

    /// <summary>
    ///   Exibe um diálogo com semântica informativa.
    /// </summary>
    /// <param name="ATitle">Título apresentado no diálogo.</param>
    /// <param name="AMessageText">Mensagem apresentada ao usuário.</param>
    /// <param name="APrimaryCaption">Texto da ação principal.</param>
    /// <param name="ASecondaryCaption">Texto opcional da ação secundária.</param>
    /// <returns>A ação selecionada pelo usuário.</returns>
    function Information(const ATitle: string; const AMessageText: string;
      const APrimaryCaption: string = 'Entendi';
      const ASecondaryCaption: string = ''): TRickDialogProResult;

    /// <summary>
    ///   Exibe um diálogo com semântica de sucesso.
    /// </summary>
    /// <param name="ATitle">Título apresentado no diálogo.</param>
    /// <param name="AMessageText">Mensagem apresentada ao usuário.</param>
    /// <param name="APrimaryCaption">Texto da ação principal.</param>
    /// <param name="ASecondaryCaption">Texto opcional da ação secundária.</param>
    /// <returns>A ação selecionada pelo usuário.</returns>
    function Success(const ATitle: string; const AMessageText: string;
      const APrimaryCaption: string = 'Concluir';
      const ASecondaryCaption: string = ''): TRickDialogProResult;
  end;

implementation

end.
