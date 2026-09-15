{ ******************************************************* }
{ Project: RickDialogPro }
{ Objective: FireMonkey Runtime Dialog Renderer }
{ Author: Ricardo R. Pereira }
{ Created: 11/09/2026 }
{ }
{ Summary: }
{ Implements the FireMonkey renderer responsible }
{ for creating modal dialogs entirely at runtime. }
{ Rendering depends on IRickDialogProTheme and keeps }
{ business rules outside the framework. }
{ }
{ Copyright (c) 2026 Ricardo R. Pereira }
{ All rights reserved. }
{ }
{ EXCLUSIVE INTELLECTUAL PROPERTY. }
{ This source code was developed entirely on personal }
{ time and with personal resources, without any }
{ employment or corporate relationship that could }
{ claim rights over it. }
{ }
{ Unauthorized copying, distribution, modification, }
{ or use is strictly prohibited without prior written }
{ permission from the author. }
{ }
{ The author reserves the right to revoke usage }
{ permission at any time, for any reason, upon formal }
{ notification. }
{ }
{ Unauthorized use constitutes copyright infringement }
{ and is subject to applicable civil and criminal }
{ penalties. }
{ ******************************************************* }

unit Rick.Dialog.Pro.Impl.FMX;

interface

uses
  Rick.Dialog.Pro.Interf,
  Rick.Dialog.Pro.Theme.Interf,
  Rick.Dialog.Pro.Types;

type
  /// <summary>
  /// Implementação FireMonkey de <see cref="IRickDialogPro"/>.
  /// </summary>
  /// <remarks>
  /// A classe cria um formulário modal totalmente em runtime e delega todas
  /// as decisões de cor ao tema informado.
  ///
  /// A aplicação consumidora deve preferir TRickDialogPro.New em vez de criar
  /// esta classe diretamente.
  /// </remarks>
  TRickDialogProFMX = class sealed(TInterfacedObject, IRickDialogPro)
  private
    /// <summary>
    /// Tema visual utilizado na criação dos diálogos.
    /// </summary>
    FTheme: IRickDialogProTheme;

  protected
    /// <summary>
    /// Exibe o diálogo conforme a configuração informada.
    /// </summary>
    /// <param name="AConfig">
    /// Configuração de conteúdo e ações do diálogo.
    /// </param>
    /// <returns>
    /// A ação selecionada pelo usuário.
    /// </returns>
    function Execute(const AConfig: TRickDialogProConfig): TRickDialogProResult;

    /// <summary>Exibe um diálogo de erro.</summary>
    /// <param name="ATitle">Título apresentado no diálogo.</param>
    /// <param name="AMessageText">Mensagem apresentada ao usuário.</param>
    /// <param name="APrimaryCaption">Texto da ação principal.</param>
    /// <param name="ASecondaryCaption">Texto opcional da ação secundária.</param>
    /// <returns>A ação selecionada pelo usuário.</returns>
    function Error(const ATitle: string; const AMessageText: string;
      const APrimaryCaption: string = 'Fechar';
      const ASecondaryCaption: string = ''): TRickDialogProResult;

    /// <summary>Exibe um diálogo de atenção.</summary>
    /// <param name="ATitle">Título apresentado no diálogo.</param>
    /// <param name="AMessageText">Mensagem apresentada ao usuário.</param>
    /// <param name="APrimaryCaption">Texto da ação principal.</param>
    /// <param name="ASecondaryCaption">Texto opcional da ação secundária.</param>
    /// <returns>A ação selecionada pelo usuário.</returns>
    function Warning(const ATitle: string; const AMessageText: string;
      const APrimaryCaption: string = 'Entendi';
      const ASecondaryCaption: string = ''): TRickDialogProResult;

    /// <summary>Exibe um diálogo informativo.</summary>
    /// <param name="ATitle">Título apresentado no diálogo.</param>
    /// <param name="AMessageText">Mensagem apresentada ao usuário.</param>
    /// <param name="APrimaryCaption">Texto da ação principal.</param>
    /// <param name="ASecondaryCaption">Texto opcional da ação secundária.</param>
    /// <returns>A ação selecionada pelo usuário.</returns>
    function Information(const ATitle: string; const AMessageText: string;
      const APrimaryCaption: string = 'Entendi';
      const ASecondaryCaption: string = ''): TRickDialogProResult;

    /// <summary>Exibe um diálogo de sucesso.</summary>
    /// <param name="ATitle">Título apresentado no diálogo.</param>
    /// <param name="AMessageText">Mensagem apresentada ao usuário.</param>
    /// <param name="APrimaryCaption">Texto da ação principal.</param>
    /// <param name="ASecondaryCaption">Texto opcional da ação secundária.</param>
    /// <returns>A ação selecionada pelo usuário.</returns>
    function Success(const ATitle: string; const AMessageText: string;
      const APrimaryCaption: string = 'Concluir';
      const ASecondaryCaption: string = ''): TRickDialogProResult;

    /// <summary>
    /// Inicializa a implementação com o tema informado.
    /// </summary>
    /// <param name="ATheme">
    /// Tema visual utilizado pelo renderer.
    /// </param>
    /// <exception cref="EArgumentNilException">
    /// Lançada quando o tema informado é nil.
    /// </exception>
    constructor Create(const ATheme: IRickDialogProTheme);

  public
    /// <summary>
    /// Cria a implementação FMX encapsulada pela interface pública.
    /// </summary>
    /// <param name="ATheme">
    /// Tema visual utilizado pelo renderer.
    /// </param>
    /// <returns>
    /// Instância de <see cref="IRickDialogPro"/>.
    /// </returns>
    class function New(const ATheme: IRickDialogProTheme): IRickDialogPro; static;
  end;

implementation

uses
  Rick.Dialog.Pro.Impl.FMX.Runtime.Form,

  System.SysUtils;

{ TRickDialogProFMX }

constructor TRickDialogProFMX.Create(const ATheme: IRickDialogProTheme);
begin
  inherited Create;

  if not Assigned(ATheme) then
    raise EArgumentNilException.Create
    ('O tema visual do RickDialogPro não foi informado.');

  FTheme := ATheme;
end;

class function TRickDialogProFMX.New(const ATheme: IRickDialogProTheme)
: IRickDialogPro;
begin
  Result := TRickDialogProFMX.Create(ATheme);
end;

function TRickDialogProFMX.Execute(const AConfig: TRickDialogProConfig)
: TRickDialogProResult;
var
  LForm: TRickDialogProRuntimeForm;
begin
  LForm := nil;
  try
    LForm := TRickDialogProRuntimeForm.Create(nil, AConfig, FTheme);

    Result := LForm.Execute;
  finally
    LForm.Free;
  end;
end;

function TRickDialogProFMX.Error(const ATitle, AMessageText, APrimaryCaption,
  ASecondaryCaption: string): TRickDialogProResult;
begin
  Result := Execute(TRickDialogProConfig.Error(ATitle, AMessageText,
      APrimaryCaption, ASecondaryCaption));
end;

function TRickDialogProFMX.Warning(const ATitle, AMessageText, APrimaryCaption,
  ASecondaryCaption: string): TRickDialogProResult;
begin
  Result := Execute(TRickDialogProConfig.Warning(ATitle, AMessageText,
      APrimaryCaption, ASecondaryCaption));
end;

function TRickDialogProFMX.Information(const ATitle, AMessageText,
  APrimaryCaption, ASecondaryCaption: string): TRickDialogProResult;
begin
  Result := Execute(TRickDialogProConfig.Information(ATitle, AMessageText,
      APrimaryCaption, ASecondaryCaption));
end;

function TRickDialogProFMX.Success(const ATitle, AMessageText, APrimaryCaption,
  ASecondaryCaption: string): TRickDialogProResult;
begin
  Result := Execute(TRickDialogProConfig.Success(ATitle, AMessageText,
      APrimaryCaption, ASecondaryCaption));
end;

end.
