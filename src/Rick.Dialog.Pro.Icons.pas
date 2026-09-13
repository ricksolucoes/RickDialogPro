{*******************************************************}
{   Project: RickDialogPro                              }
{   Objective: Vector Icon Definitions                  }
{   Author: Ricardo R. Pereira                          }
{   Created: 11/09/2026                                 }
{                                                       }
{   Summary:                                            }
{    Centralizes the SVG path data used by RickDialogPro}
{    to render the semantic icons for error, warning,   }
{    information and success dialogs at runtime.        }
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
unit Rick.Dialog.Pro.Icons;

interface

uses
  Rick.Dialog.Pro.Types;

type
  /// <summary>
  /// Catálogo interno de ícones vetoriais utilizados pelo RickDialogPro.
  /// </summary>
  /// <remarks>
  /// Os desenhos foram extraídos dos arquivos SVG fornecidos ao projeto:
  ///
  /// - error-filled-svgrepo-com.svg
  /// - error-svgrepo-com.svg
  /// - information-3-svgrepo-com.svg
  /// - ok-circle-filled-svgrepo-com.svg
  ///
  /// Nenhum arquivo SVG externo é necessário em runtime.
  /// </remarks>
  TRickDialogProIcons = class sealed
  strict private
    /// <summary>
    /// Retorna os dados vetoriais do ícone de erro.
    /// </summary>
    class function ErrorIcon: TRickDialogProIconData; static;

    /// <summary>
    /// Retorna os dados vetoriais do ícone de atenção.
    /// </summary>
    class function WarningIcon: TRickDialogProIconData; static;

    /// <summary>
    /// Retorna os dados vetoriais do ícone informativo.
    /// </summary>
    class function InformationIcon: TRickDialogProIconData; static;

    /// <summary>
    /// Retorna os dados vetoriais do ícone de sucesso.
    /// </summary>
    class function SuccessIcon: TRickDialogProIconData; static;

  public
    /// <summary>
    /// Retorna os dados vetoriais correspondentes ao tipo semântico
    /// informado.
    /// </summary>
    /// <param name="AKind">
    /// Tipo semântico do diálogo.
    /// </param>
    /// <returns>
    /// Dados do path e dimensões lógicas do ícone correspondente.
    /// </returns>
    class function Resolve(AKind: TRickDialogProKind): TRickDialogProIconData; static;
  end;

implementation

const
  { --------------------------------------------------------------------------- }
  { Erro }
  { Arquivo de origem: error-filled-svgrepo-com.svg }
  { SVG original: viewBox="0 0 512 512" com translate(42.666667,42.666667). }
  { O path abaixo foi normalizado para sua área vetorial efetiva 426.666667. }
  { --------------------------------------------------------------------------- }
  _ICON_ERROR_PATH = 'M213.333333,0 ' +
  'C331.136,0 426.666667,95.5306667 426.666667,213.333333 ' +
  'C426.666667,331.136 331.136,426.666667 213.333333,426.666667 ' +
  'C95.5306667,426.666667 0,331.136 0,213.333333 ' +
  'C0,95.5306667 95.5306667,0 213.333333,0 ' + 'Z ' + 'M262.250667,134.250667 '
  + 'L213.333333,183.168 ' + 'L164.416,134.250667 ' + 'L134.250667,164.416 ' +
  'L183.168,213.333333 ' + 'L134.250667,262.250667 ' + 'L164.416,292.416 ' +
  'L213.333333,243.498667 ' + 'L262.250667,292.416 ' + 'L292.416,262.250667 ' +
  'L243.498667,213.333333 ' + 'L292.416,164.416 ' +
  'L262.250667,134.250667 ' + 'Z';

  _ICON_ERROR_VIEWBOX_WIDTH = 426.666667;
  _ICON_ERROR_VIEWBOX_HEIGHT = 426.666667;

  { --------------------------------------------------------------------------- }
  { Atenção }
  { Arquivo de origem: error-svgrepo-com.svg }
  { SVG original: viewBox="0 0 24 24". }
  { --------------------------------------------------------------------------- }
  _ICON_WARNING_PATH = 'M12 22 ' + 'C17.523 22 22 17.523 22 12 ' +
  'S17.523 2 12 2 ' + 'S2 6.477 2 12 ' + 'S6.477 22 12 22 ' + 'Z ' +
  'M10.5 16.991 ' + 'C10.5 16.124 11.159 15.5 11.991 15.5 ' +
  'C12.841 15.5 13.5 16.124 13.5 16.991 ' +
  'C13.5 17.858 12.841 18.5 11.991 18.5 ' +
  'C11.159 18.5 10.5 17.858 10.5 16.991 ' + 'Z ' + 'M11.172 6 ' +
  'C10.884 6 10.655 6.241 10.673 6.522 ' + 'L10.979 13.522 ' +
  'C10.991 13.789 11.21 14 11.479 14 ' + 'L12.522 14 ' +
  'C12.79 14 13.01 13.789 13.022 13.522 ' + 'L13.327 6.522 ' +
  'C13.345 6.241 13.116 6 12.827 6 ' + 'L11.172 6 ' + 'Z';

  _ICON_WARNING_VIEWBOX_WIDTH = 24;
  _ICON_WARNING_VIEWBOX_HEIGHT = 24;

  { --------------------------------------------------------------------------- }
  { Informação }
  { Arquivo de origem: information-3-svgrepo-com.svg }
  { SVG original: viewBox="0 0 512 512". }
  { --------------------------------------------------------------------------- }
  _ICON_INFORMATION_PATH = 'M255.992,0.008 ' + 'C114.626,0.008 0,114.626 0,256 '
  + 'S114.626,511.992 255.992,511.992 ' +
  'C397.391,511.992 512,397.375 512,256 ' + 'S397.391,0.008 255.992,0.008 ' +
  'Z ' + 'M300.942,373.528 ' + 'C290.587,385.02 284.652,391.85 273.475,402.535 '
  + 'C256.557,418.712 237.347,423.019 222.412,407.051 ' +
  'C200.945,384.092 223.46,314.247 224.009,311.602 ' +
  'C228.041,293.038 236.089,255.935 236.089,255.935 ' +
  'S218.702,266.579 208.38,270.354 ' +
  'C200.767,273.136 192.155,269.483 190.026,262.12 ' +
  'C188.042,255.298 189.622,250.959 193.8,246.298 ' +
  'C204.154,234.814 210.089,227.984 221.267,217.299 ' +
  'C238.201,201.114 257.395,196.816 272.33,212.775 ' +
  'C293.797,235.734 277.958,273.507 272.394,300.272 ' +
  'C271.846,302.925 258.652,363.899 258.652,363.899 ' +
  'S276.039,353.254 286.361,349.472 ' +
  'C293.989,346.698 302.602,350.359 304.731,357.714 ' +
  'C306.716,364.537 305.12,368.875 300.942,373.528 ' + 'Z ' +
  'M273.169,176.123 ' + 'C249.283,178.219 228.235,160.559 226.138,136.656 ' +
  'C224.058,112.778 241.728,91.722 265.615,89.642 ' +
  'C289.485,87.545 310.549,105.222 312.63,129.1 ' +
  'C314.716,152.979 297.039,174.043 273.169,176.123 ' + 'Z';

  _ICON_INFORMATION_VIEWBOX_WIDTH = 512;
  _ICON_INFORMATION_VIEWBOX_HEIGHT = 512;

  { --------------------------------------------------------------------------- }
  { Sucesso }
  { Arquivo de origem: ok-circle-filled-svgrepo-com.svg }
  { SVG original: viewBox="0 0 24 24". }
  { O <rect class="st0" .../> transparente do SVG não é necessário ao TPath. }
  { --------------------------------------------------------------------------- }
  _ICON_SUCCESS_PATH = 'M12,2 ' + 'C6.5,2 2,6.5 2,12 ' + 'S6.5,22 12,22 ' +
  'S22,17.5 22,12 ' + 'S17.5,2 12,2 ' + 'Z ' + 'M10.8,16.8 ' + 'L7.1,13.1 ' +
  'L8.5,11.7 ' + 'L10.7,13.9 ' + 'L16.5,7.8 ' + 'L18,9.3 ' +
  'L10.8,16.8 ' + 'Z';

  _ICON_SUCCESS_VIEWBOX_WIDTH = 24;
  _ICON_SUCCESS_VIEWBOX_HEIGHT = 24;

  { TRickDialogProIcons }

class function TRickDialogProIcons.ErrorIcon: TRickDialogProIconData;
begin
  Result.PathData := _ICON_ERROR_PATH;
  Result.ViewBoxWidth := _ICON_ERROR_VIEWBOX_WIDTH;
  Result.ViewBoxHeight := _ICON_ERROR_VIEWBOX_HEIGHT;
end;

class function TRickDialogProIcons.WarningIcon: TRickDialogProIconData;
begin
  Result.PathData := _ICON_WARNING_PATH;
  Result.ViewBoxWidth := _ICON_WARNING_VIEWBOX_WIDTH;
  Result.ViewBoxHeight := _ICON_WARNING_VIEWBOX_HEIGHT;
end;

class function TRickDialogProIcons.InformationIcon: TRickDialogProIconData;
begin
  Result.PathData := _ICON_INFORMATION_PATH;
  Result.ViewBoxWidth := _ICON_INFORMATION_VIEWBOX_WIDTH;
  Result.ViewBoxHeight := _ICON_INFORMATION_VIEWBOX_HEIGHT;
end;

class function TRickDialogProIcons.SuccessIcon: TRickDialogProIconData;
begin
  Result.PathData := _ICON_SUCCESS_PATH;
  Result.ViewBoxWidth := _ICON_SUCCESS_VIEWBOX_WIDTH;
  Result.ViewBoxHeight := _ICON_SUCCESS_VIEWBOX_HEIGHT;
end;

class function TRickDialogProIcons.Resolve(AKind: TRickDialogProKind)
: TRickDialogProIconData;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := ErrorIcon;

    TRickDialogProKind.Warning:
      Result := WarningIcon;

    TRickDialogProKind.Information:
      Result := InformationIcon;

    TRickDialogProKind.Success:
      Result := SuccessIcon;
    else
      Result := InformationIcon;
  end;
end;

end.
