{*******************************************************}
{   Project: RickDialogPro                              }
{   Objective: Public Types and Dialog Configuration    }
{   Author: Ricardo R. Pereira                          }
{   Created: 11/09/2026                                 }
{                                                       }
{   Summary:                                            }
{     Defines the public semantic types used by         }
{     RickDialogPro, including dialog kind, user action }
{     result, and the configuration record used to      }
{     describe title, message and available actions.    }
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

unit Rick.Dialog.Pro.Types;

interface

type
  {$SCOPEDENUMS ON}
  /// <summary>
  /// Define a natureza semântica do diálogo.
  /// </summary>
  /// <remarks>
  /// O valor determina o conjunto de cores, o ícone e o estilo do botão
  /// principal que serão solicitados ao tema visual ativo.
  /// </remarks>
  TRickDialogProKind = (Error, Warning, Information, Success);

  /// <summary>
  /// Identifica a ação selecionada pelo usuário no diálogo.
  /// </summary>
  /// <remarks>
  /// O framework apenas informa qual ação foi escolhida. O significado de
  /// negócio de Primary e Secondary pertence à aplicação consumidora.
  /// </remarks>
  TRickDialogProResult = (None, Primary, Secondary);
  {$SCOPEDENUMS OFF}

  /// <summary>
  /// Define o conteúdo e as ações apresentadas por um diálogo.
  /// </summary>
  /// <remarks>
  /// A configuração contém somente dados de apresentação e seleção de ação.
  /// Cores e identidade visual são fornecidas por IRickDialogProTheme.
  /// </remarks>
  TRickDialogProConfig = record
  strict private
    /// <summary>
    /// Cria a configuração base para um tipo de diálogo.
    /// </summary>
    /// <param name="AKind">
    /// Natureza semântica do diálogo.
    /// </param>
    /// <param name="ATitle">
    /// Título apresentado em destaque.
    /// </param>
    /// <param name="AMessageText">
    /// Mensagem principal apresentada ao usuário.
    /// </param>
    /// <param name="APrimaryCaption">
    /// Texto do botão de ação principal.
    /// </param>
    /// <param name="ASecondaryCaption">
    /// Texto do botão de ação secundária. Quando vazio, o botão secundário
    /// não é exibido.
    /// </param>
    /// <returns>
    /// Configuração preenchida com os valores informados.
    /// </returns>
    class function Build(AKind: TRickDialogProKind; const ATitle: string;
      const AMessageText: string; const APrimaryCaption: string;
      const ASecondaryCaption: string): TRickDialogProConfig; static;
  public
    /// <summary>
    /// Natureza semântica do diálogo.
    /// </summary>
    Kind: TRickDialogProKind;

    /// <summary>
    /// Título apresentado em destaque.
    /// </summary>
    Title: string;

    /// <summary>
    /// Mensagem principal apresentada ao usuário.
    /// </summary>
    MessageText: string;

    /// <summary>
    /// Texto do botão de ação principal.
    /// </summary>
    PrimaryCaption: string;

    /// <summary>
    /// Texto do botão de ação secundária.
    /// </summary>
    SecondaryCaption: string;

    /// <summary>
    /// Define se o botão de ação secundária deve ser renderizado.
    /// </summary>
    ShowSecondary: Boolean;

    /// <summary>
    /// Retorna uma configuração inicial com semântica informativa.
    /// </summary>
    /// <returns>
    /// Configuração padrão do RickDialogPro.
    /// </returns>
    class function Default: TRickDialogProConfig; static;

    /// <summary>
    /// Cria uma configuração para um diálogo de erro.
    /// </summary>
    /// <param name="ATitle">Título apresentado no diálogo.</param>
    /// <param name="AMessageText">Mensagem apresentada ao usuário.</param>
    /// <param name="APrimaryCaption">Texto da ação principal.</param>
    /// <param name="ASecondaryCaption">Texto opcional da ação secundária.</param>
    /// <returns>Configuração com semântica de erro.</returns>
    class function Error(const ATitle: string; const AMessageText: string;
      const APrimaryCaption: string = 'Fechar';
      const ASecondaryCaption: string = ''): TRickDialogProConfig; static;

    /// <summary>
    /// Cria uma configuração para um diálogo de atenção.
    /// </summary>
    /// <param name="ATitle">Título apresentado no diálogo.</param>
    /// <param name="AMessageText">Mensagem apresentada ao usuário.</param>
    /// <param name="APrimaryCaption">Texto da ação principal.</param>
    /// <param name="ASecondaryCaption">Texto opcional da ação secundária.</param>
    /// <returns>Configuração com semântica de atenção.</returns>
    class function Warning(const ATitle: string; const AMessageText: string;
      const APrimaryCaption: string = 'Entendi';
      const ASecondaryCaption: string = ''): TRickDialogProConfig; static;

    /// <summary>
    /// Cria uma configuração para um diálogo informativo.
    /// </summary>
    /// <param name="ATitle">Título apresentado no diálogo.</param>
    /// <param name="AMessageText">Mensagem apresentada ao usuário.</param>
    /// <param name="APrimaryCaption">Texto da ação principal.</param>
    /// <param name="ASecondaryCaption">Texto opcional da ação secundária.</param>
    /// <returns>Configuração com semântica informativa.</returns>
    class function Information(const ATitle: string; const AMessageText: string;
      const APrimaryCaption: string = 'Entendi';
      const ASecondaryCaption: string = ''): TRickDialogProConfig; static;

    /// <summary>
    /// Cria uma configuração para um diálogo de sucesso.
    /// </summary>
    /// <param name="ATitle">Título apresentado no diálogo.</param>
    /// <param name="AMessageText">Mensagem apresentada ao usuário.</param>
    /// <param name="APrimaryCaption">Texto da ação principal.</param>
    /// <param name="ASecondaryCaption">Texto opcional da ação secundária.</param>
    /// <returns>Configuração com semântica de sucesso.</returns>
    class function Success(const ATitle: string; const AMessageText: string;
      const APrimaryCaption: string = 'Concluir';
      const ASecondaryCaption: string = ''): TRickDialogProConfig; static;
  end;

  /// <summary>
  /// Define os dados vetoriais necessários para renderizar um ícone do
  /// RickDialogPro através de TPath.
  /// </summary>
  /// <remarks>
  /// Os dados são independentes de cor. A identidade visual continua sendo
  /// fornecida por IRickDialogProTheme.
  ///
  /// ViewBoxWidth e ViewBoxHeight preservam as dimensões lógicas do desenho
  /// original e permitem que o renderer aplique escala proporcional sem
  /// depender do tamanho físico do SVG de origem.
  /// </remarks>
  TRickDialogProIconData = record
    /// <summary>
    /// Comandos vetoriais compatíveis com o formato de path utilizado pelo
    /// FireMonkey.
    /// </summary>
    PathData: string;

    /// <summary>
    /// Largura lógica utilizada pelo desenho vetorial.
    /// </summary>
    ViewBoxWidth: Single;

    /// <summary>
    /// Altura lógica utilizada pelo desenho vetorial.
    /// </summary>
    ViewBoxHeight: Single;
  end;

implementation

uses
  System.SysUtils;

{ TRickDialogProConfig }

class function TRickDialogProConfig.Build(AKind: TRickDialogProKind;
  const ATitle, AMessageText, APrimaryCaption, ASecondaryCaption: string)
: TRickDialogProConfig;
begin
  Result := Default;
  Result.Kind := AKind;
  Result.Title := ATitle;
  Result.MessageText := AMessageText;
  Result.PrimaryCaption := APrimaryCaption;
  Result.SecondaryCaption := ASecondaryCaption;
  Result.ShowSecondary := Trim(ASecondaryCaption) <> EmptyStr;
end;

class function TRickDialogProConfig.Default: TRickDialogProConfig;
begin
  Result.Kind := TRickDialogProKind.Information;
  Result.Title := EmptyStr;
  Result.MessageText := EmptyStr;
  Result.PrimaryCaption := 'Entendi';
  Result.SecondaryCaption := EmptyStr;
  Result.ShowSecondary := False;
end;

class function TRickDialogProConfig.Error(const ATitle, AMessageText,
  APrimaryCaption, ASecondaryCaption: string): TRickDialogProConfig;
begin
  Result := Build(TRickDialogProKind.Error, ATitle, AMessageText,
    APrimaryCaption, ASecondaryCaption);
end;

class function TRickDialogProConfig.Warning(const ATitle, AMessageText,
  APrimaryCaption, ASecondaryCaption: string): TRickDialogProConfig;
begin
  Result := Build(TRickDialogProKind.Warning, ATitle, AMessageText,
    APrimaryCaption, ASecondaryCaption);
end;

class function TRickDialogProConfig.Information(const ATitle, AMessageText,
  APrimaryCaption, ASecondaryCaption: string): TRickDialogProConfig;
begin
  Result := Build(TRickDialogProKind.Information, ATitle, AMessageText,
    APrimaryCaption, ASecondaryCaption);
end;

class function TRickDialogProConfig.Success(const ATitle, AMessageText,
  APrimaryCaption, ASecondaryCaption: string): TRickDialogProConfig;
begin
  Result := Build(TRickDialogProKind.Success, ATitle, AMessageText,
    APrimaryCaption, ASecondaryCaption);
end;

end.
