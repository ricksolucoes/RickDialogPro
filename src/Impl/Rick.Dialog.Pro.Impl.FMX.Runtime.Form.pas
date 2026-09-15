{*******************************************************}
{   Project: RickDialogPro                              }
{   Objective: FireMonkey Runtime Dialog Renderer       }
{   Author: Ricardo R. Pereira                          }
{   Created: 11/09/2026                                 }
{                                                       }
{   Summary:                                            }
{     Implements the FireMonkey renderer responsible    }
{     for creating modal dialogs entirely at runtime.   }
{     Rendering depends on IRickDialogProTheme and keeps}
{     business rules outside the framework.             }
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

unit Rick.Dialog.Pro.Impl.FMX.Runtime.Form;

interface

uses
  System.Classes,
  System.Types,
  System.UITypes,

  FMX.Forms,
  FMX.Graphics,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types,

  Rick.Dialog.Pro.Theme.Interf,
  Rick.Dialog.Pro.Types;

type
  /// <summary>
  ///   Formulário modal interno utilizado pelo renderer FMX.
  /// </summary>
  /// <remarks>
  ///   O formulário não possui arquivo .fmx. Todos os componentes são criados
  ///   em runtime e pertencem ao ciclo de vida da própria instância.
  /// </remarks>
  TRickDialogProRuntimeForm = class sealed(TForm)
  strict private
    /// <summary>
    ///   Configuração utilizada para criar o conteúdo do diálogo.
    /// </summary>
    FConfig: TRickDialogProConfig;

    /// <summary>
    ///   Tema visual utilizado durante a renderização.
    /// </summary>
    FTheme: IRickDialogProTheme;

    /// <summary>
    ///   Resultado selecionado pelo usuário.
    /// </summary>
    FResult: TRickDialogProResult;

    /// <summary>
    ///   Card principal que agrupa o conteúdo do diálogo.
    /// </summary>
    FCard: TRectangle;

    /// <summary>
    ///   Balão reutilizado para apresentar o conteúdo completo de textos
    ///   truncados.
    /// </summary>
    FTextTooltip: TRectangle;

    /// <summary>
    ///   Label interno utilizado pelo balão de texto.
    /// </summary>
    FTextTooltipLabel: TLabel;

    /// <summary>
    ///   Configura propriedades básicas da janela modal.
    /// </summary>
    procedure ConfigureForm;

    /// <summary>
    ///   Cria todos os elementos visuais do diálogo.
    /// </summary>
    procedure BuildInterface;

    /// <summary>Cria o card principal.</summary>
    procedure CreateCard;

    /// <summary>
    ///   Cria o traço semântico superior integrado ao contorno do card.
    /// </summary>
    /// <remarks>
    ///   O traço acompanha os dois cantos superiores arredondados e substitui
    ///   visualmente a borda comum nessa região.
    /// </remarks>
    procedure CreateTopBar;

    /// <summary>Cria o círculo e o desenho vetorial do ícone.</summary>
    procedure CreateIcon;

    /// <summary>Cria o título e a mensagem principal.</summary>
    procedure CreateTexts;

    /// <summary>Cria os botões de ação disponíveis.</summary>
    procedure CreateButtons;

    /// <summary>
    ///   Cria um texto FireMonkey com estilo controlado pelo framework.
    /// </summary>
    /// <param name="AParent">Componente visual que receberá o texto.</param>
    /// <param name="AText">Conteúdo textual.</param>
    /// <param name="ALeft">Posição horizontal.</param>
    /// <param name="ATop">Posição vertical.</param>
    /// <param name="AWidth">Largura do componente.</param>
    /// <param name="AHeight">Altura do componente.</param>
    /// <param name="AFontSize">Tamanho da fonte.</param>
    /// <param name="AFontColor">Cor da fonte.</param>
    /// <param name="AHorizontalAlign">Alinhamento horizontal.</param>
    /// <param name="ABold">Define se a fonte utiliza negrito.</param>
    /// <returns>Label criado e associado ao formulário.</returns>
    function CreateText(AParent: TFmxObject; const AText: string;
      ALeft: Single; ATop: Single; AWidth: Single; AHeight: Single;
      AFontSize: Single; AFontColor: TAlphaColor;
      AHorizontalAlign: TTextAlign = TTextAlign.Leading;
      ABold: Boolean = False): TLabel;

    /// <summary>
    ///   Cria um retângulo utilizado na composição visual do diálogo.
    /// </summary>
    /// <param name="AParent">Componente visual pai.</param>
    /// <param name="ALeft">Posição horizontal.</param>
    /// <param name="ATop">Posição vertical.</param>
    /// <param name="AWidth">Largura do componente.</param>
    /// <param name="AHeight">Altura do componente.</param>
    /// <param name="AFillColor">Cor de preenchimento.</param>
    /// <param name="AStrokeColor">Cor da borda.</param>
    /// <param name="ARadius">Raio dos cantos.</param>
    /// <returns>Retângulo criado e associado ao formulário.</returns>
    function CreateRectangle(AParent: TFmxObject; ALeft: Single; ATop: Single;
      AWidth: Single; AHeight: Single; AFillColor: TAlphaColor;
      AStrokeColor: TAlphaColor; ARadius: Single): TRectangle;

    /// <summary>
    ///   Cria um botão de ação baseado em TRectangle.
    /// </summary>
    /// <param name="ACaption">Texto exibido no botão.</param>
    /// <param name="ALeft">Posição horizontal.</param>
    /// <param name="AWidth">Largura do botão.</param>
    /// <param name="ATag">Identificador interno da ação.</param>
    /// <param name="AFillColor">Cor normal de preenchimento.</param>
    /// <param name="ATextColor">Cor do texto.</param>
    /// <returns>Retângulo configurado como botão.</returns>
    function CreateActionButton(const ACaption: string; ALeft: Single;
      AWidth: Single; ATag: NativeInt; AFillColor: TAlphaColor;
      ATextColor: TAlphaColor): TRectangle;

    /// <summary>
    ///   Renderiza o ícone SVG correspondente ao tipo semântico atual.
    /// </summary>
    /// <param name="AParent">
    ///   Círculo translúcido que receberá o ícone.
    /// </param>
    /// <remarks>
    ///   A geometria vetorial é obtida de Rick.Dialog.Pro.Icons. A cor permanece
    ///   sob responsabilidade de IRickDialogProTheme.
    ///
    ///   O renderer utiliza TPathWrapMode.Fit para preservar a proporção
    ///   original do SVG dentro da área reservada ao ícone.
    /// </remarks>
    procedure DrawIcon(AParent: TFmxObject);

    /// <summary>
    ///   Percorre os textos criados pelo diálogo e habilita o balão somente
    ///   naqueles cujo conteúdo não cabe integralmente na área disponível.
    /// </summary>
    /// <param name="AParent">
    ///   Objeto raiz utilizado na inspeção recursiva.
    /// </param>
    procedure ConfigureOverflowTooltips(AParent: TFmxObject);

    /// <summary>
    ///   Informa se o texto do label ultrapassa a largura ou a altura
    ///   disponível para renderização.
    /// </summary>
    /// <param name="ALabel">Label que será analisado.</param>
    /// <returns>
    ///   True quando o conteúdo é maior que a área disponível.
    /// </returns>
    function IsTextOverflowing(ALabel: TLabel): Boolean;

    /// <summary>
    ///   Mede o texto utilizando o mecanismo nativo de layout do FireMonkey.
    /// </summary>
    /// <param name="AText">Texto que será medido.</param>
    /// <param name="AFont">Fonte aplicada ao texto.</param>
    /// <param name="AMaxWidth">Largura máxima utilizada na medição.</param>
    /// <param name="AWordWrap">Define se a medição considera quebra de linha.</param>
    /// <returns>
    ///   Largura e altura necessárias para renderizar o conteúdo.
    /// </returns>
    function MeasureTextSize(const AText: string; AFont: TFont;
      AMaxWidth: Single; AWordWrap: Boolean): TPointF;

    /// <summary>
    ///   Cria o balão visual na primeira utilização.
    /// </summary>
    procedure EnsureTextTooltip;

    /// <summary>
    ///   Apresenta o conteúdo integral do label no balão.
    /// </summary>
    /// <param name="ALabel">
    ///   Label de origem do conteúdo.
    /// </param>
    procedure ShowTextTooltip(ALabel: TLabel);

    /// <summary>
    ///   Oculta o balão de texto.
    /// </summary>
    procedure HideTextTooltip;

    /// <summary>
    ///   Evento disparado quando o mouse entra em um texto truncado.
    /// </summary>
    procedure TextMouseEnter(Sender: TObject);

    /// <summary>
    ///   Evento disparado quando o mouse deixa um texto truncado.
    /// </summary>
    procedure TextMouseLeave(Sender: TObject);

    /// <summary>
    ///   Verifica se um botão possui caption truncado e, quando necessário,
    ///   apresenta o mesmo balão sem interferir no clique do botão.
    /// </summary>
    /// <param name="AButton">Botão que será inspecionado.</param>
    procedure ShowButtonTextTooltip(AButton: TRectangle);

    /// <summary>
    ///   Registra a ação selecionada e encerra o modo modal.
    /// </summary>
    procedure ButtonClick(Sender: TObject);

    /// <summary>
    ///   Aplica a cor de hover conforme o botão apontado pelo mouse.
    /// </summary>
    procedure ButtonMouseEnter(Sender: TObject);

    /// <summary>
    ///   Restaura a cor normal do botão quando o mouse deixa sua área.
    /// </summary>
    procedure ButtonMouseLeave(Sender: TObject);
  public
    /// <summary>
    ///   Cria o formulário interno com a configuração e o tema informados.
    /// </summary>
    /// <param name="AOwner">Owner do formulário. Pode ser nil.</param>
    /// <param name="AConfig">Configuração do conteúdo e das ações.</param>
    /// <param name="ATheme">Tema visual utilizado pelo renderer.</param>
    constructor Create(AOwner: TComponent; const AConfig: TRickDialogProConfig;
      const ATheme: IRickDialogProTheme); reintroduce;

    /// <summary>
    ///   Exibe o formulário em modo modal.
    /// </summary>
    /// <returns>A ação selecionada pelo usuário.</returns>
    function Execute: TRickDialogProResult;
  end;

implementation

uses
  Rick.Dialog.Pro.Icons,

  System.SysUtils,

  FMX.Controls,
  FMX.TextLayout;

const
  // ---------- Janela ----------
  _DIALOG_WIDTH               = 584;
  _DIALOG_HEIGHT              = 319;

  // ---------- Card ----------
  _CARD_RADIUS                = 16;
  _TOP_BORDER_HEIGHT          = 18;
  _TOP_BORDER_THICKNESS       = 3;

  // ---------- Conteúdo ----------
  _CONTENT_LEFT               = 138;
  _CONTENT_RIGHT_MARGIN       = 38;

  // ---------- Ícone ----------
  _ICON_LEFT                  = 42;
  _ICON_TOP                   = 54;
  _ICON_SIZE                  = 72;
  _ICON_VECTOR_MARGIN         = 18;
  _ICON_VECTOR_SIZE           = _ICON_SIZE - (_ICON_VECTOR_MARGIN * 2);

  // ---------- Título ----------
  _TITLE_TOP                  = 48;
  _TITLE_HEIGHT               = 38;
  _TITLE_FONT_SIZE            = 24;

  // ---------- Mensagem ----------
  _MESSAGE_TOP                = 94;
  _MESSAGE_HEIGHT             = 112;
  _MESSAGE_FONT_SIZE          = 18;

  // ---------- Botões ----------
  _BUTTON_TOP                 = 238;
  _BUTTON_HEIGHT              = 56;
  _PRIMARY_BUTTON_WIDTH       = 190;
  _SECONDARY_BUTTON_WIDTH     = 150;
  _BUTTON_GAP                 = 16;

  // ---------- Balão para texto truncado ----------
  _TOOLTIP_MIN_WIDTH          = 220;
  _TOOLTIP_MAX_WIDTH          = 500;
  _TOOLTIP_MIN_HEIGHT         = 52;
  _TOOLTIP_PADDING            = 14;
  _TOOLTIP_MARGIN             = 12;
  _TOOLTIP_GAP                = 8;
  _TOOLTIP_RADIUS             = 12;
  _TOOLTIP_FONT_SIZE          = 14;
  _TEXT_OVERFLOW_TOLERANCE    = 1;

  // ---------- Identificação das ações ----------
  _TAG_PRIMARY                = 1;
  _TAG_SECONDARY              = 2;

{ TRickDialogProRuntimeForm }

constructor TRickDialogProRuntimeForm.Create(AOwner: TComponent;
  const AConfig: TRickDialogProConfig; const ATheme: IRickDialogProTheme);
begin
  inherited CreateNew(AOwner);

  FConfig := AConfig;          // Mantém o conteúdo durante toda a exibição.
  FTheme := ATheme;            // Mantém o tema enquanto o formulário existir.
  FResult := TRickDialogProResult.None; // Estado inicial sem ação selecionada.

  ConfigureForm;
  BuildInterface;
end;

procedure TRickDialogProRuntimeForm.ConfigureForm;
begin
  Caption := FConfig.Title;
  Width := _DIALOG_WIDTH;
  Height := _DIALOG_HEIGHT;
  BorderStyle := TFmxFormBorderStyle.None;
  Position := TFormPosition.ScreenCenter;

  // A janela existe somente como host do card. A transparência elimina
  // qualquer moldura/fundo externo e preserva visualmente os cantos
  // arredondados do diálogo.
  Transparency := True;
  Fill.Kind := TBrushKind.Solid;
  Fill.Color := TAlphaColor($00000000);

  if FConfig.UseBackground then
    Fill.Color := FTheme.Background;
end;

procedure TRickDialogProRuntimeForm.BuildInterface;
begin
  CreateCard;
  CreateTopBar;
  CreateIcon;
  CreateTexts;
  CreateButtons;

  // A inspeção é executada somente depois que todos os textos receberam
  // tamanho, fonte, alinhamento e WordWrap definitivos.
  ConfigureOverflowTooltips(FCard);
end;

procedure TRickDialogProRuntimeForm.CreateCard;
begin
  FCard := CreateRectangle(Self, 0, 0, _DIALOG_WIDTH, _DIALOG_HEIGHT,
    FTheme.Surface, FTheme.Border, _CARD_RADIUS);

  FCard.Stroke.Thickness := 2;
end;

procedure TRickDialogProRuntimeForm.CreateTopBar;
var
  LTopBorder: TPath;   // Traço semântico integrado ao contorno superior.
  LCardWidth: Integer; // Largura inteira utilizada na construção do path.
  LPathData: string;   // Path com os dois cantos superiores arredondados.
begin
  LCardWidth := Round(FCard.Width);

  LPathData := Format(
    'M 2,16 ' +
    'C 2,8 8,2 16,2 ' +
    'L %d,2 ' +
    'C %d,2 %d,8 %d,16',
    [
      LCardWidth - 16,
      LCardWidth - 8,
      LCardWidth - 2,
      LCardWidth - 2
    ]
  );

  LTopBorder := TPath.Create(Self);
  LTopBorder.Parent := FCard;
  LTopBorder.Position.X := 0;
  LTopBorder.Position.Y := 0;
  LTopBorder.Width := FCard.Width;
  LTopBorder.Height := _TOP_BORDER_HEIGHT;
  LTopBorder.HitTest := False;
  LTopBorder.Fill.Kind := TBrushKind.None;
  LTopBorder.Stroke.Kind := TBrushKind.Solid;
  LTopBorder.Stroke.Color := FTheme.StatusColor(FConfig.Kind);
  LTopBorder.Stroke.Thickness := _TOP_BORDER_THICKNESS;
  LTopBorder.Data.Data := LPathData;
end;

procedure TRickDialogProRuntimeForm.CreateIcon;
var
  LCircle: TCircle; // Círculo translúcido que contém o ícone semântico.
begin
  LCircle := TCircle.Create(Self);
  LCircle.Parent := FCard;
  LCircle.Position.X := _ICON_LEFT;
  LCircle.Position.Y := _ICON_TOP;
  LCircle.Width := _ICON_SIZE;
  LCircle.Height := _ICON_SIZE;
  LCircle.HitTest := False;
  LCircle.Fill.Kind := TBrushKind.Solid;
  LCircle.Fill.Color := FTheme.IconBackground(FConfig.Kind);
  LCircle.Stroke.Kind := TBrushKind.None;

  DrawIcon(LCircle);
end;

procedure TRickDialogProRuntimeForm.CreateTexts;
var
  LTextWidth: Single; // Largura disponível para título e mensagem.
  LMessage: TLabel;   // Label da mensagem, configurado com quebra de linha.
begin
  LTextWidth := FCard.Width - _CONTENT_LEFT - _CONTENT_RIGHT_MARGIN;

  CreateText(FCard, FConfig.Title, _CONTENT_LEFT, _TITLE_TOP, LTextWidth,
    _TITLE_HEIGHT, _TITLE_FONT_SIZE, FTheme.TextPrimary,
    TTextAlign.Leading, True);

  LMessage := CreateText(FCard, FConfig.MessageText, _CONTENT_LEFT,
    _MESSAGE_TOP, LTextWidth, _MESSAGE_HEIGHT, _MESSAGE_FONT_SIZE,
    FTheme.TextSecondary, TTextAlign.Leading, False);

  LMessage.WordWrap := True;
  LMessage.TextSettings.VertAlign := TTextAlign.Leading;
end;

procedure TRickDialogProRuntimeForm.CreateButtons;
var
  LPrimaryLeft: Single;   // Posição horizontal do botão principal.
  LSecondaryLeft: Single; // Posição horizontal do botão secundário.
begin
  LPrimaryLeft := FCard.Width - _CONTENT_RIGHT_MARGIN -
    _PRIMARY_BUTTON_WIDTH;

  CreateActionButton(FConfig.PrimaryCaption, LPrimaryLeft,
    _PRIMARY_BUTTON_WIDTH, _TAG_PRIMARY,
    FTheme.PrimaryButtonBackground(FConfig.Kind),
    FTheme.PrimaryButtonText(FConfig.Kind));

  if (not FConfig.ShowSecondary) or
     (Trim(FConfig.SecondaryCaption) = EmptyStr) then
    Exit;

  LSecondaryLeft := LPrimaryLeft - _BUTTON_GAP - _SECONDARY_BUTTON_WIDTH;

  CreateActionButton(FConfig.SecondaryCaption, LSecondaryLeft,
    _SECONDARY_BUTTON_WIDTH, _TAG_SECONDARY,
    FTheme.SecondaryButtonBackground, FTheme.SecondaryButtonText);
end;

function TRickDialogProRuntimeForm.CreateText(AParent: TFmxObject;
  const AText: string; ALeft, ATop, AWidth, AHeight, AFontSize: Single;
  AFontColor: TAlphaColor; AHorizontalAlign: TTextAlign;
  ABold: Boolean): TLabel;
begin
  Result := TLabel.Create(Self);
  Result.Parent := AParent;
  Result.Position.X := ALeft;
  Result.Position.Y := ATop;
  Result.Width := AWidth;
  Result.Height := AHeight;
  Result.Text := AText;
  Result.HitTest := False;
  Result.AutoSize := False;
  Result.TextSettings.Font.Size := AFontSize;
  Result.TextSettings.FontColor := AFontColor;
  Result.TextSettings.HorzAlign := AHorizontalAlign;
  Result.TextSettings.VertAlign := TTextAlign.Center;
  Result.TextSettings.Font.Style :=
    Result.TextSettings.Font.Style - [TFontStyle.fsBold];

  if ABold then
    Result.TextSettings.Font.Style :=
      Result.TextSettings.Font.Style + [TFontStyle.fsBold];

  Result.StyledSettings := Result.StyledSettings -
    [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
end;

function TRickDialogProRuntimeForm.CreateRectangle(AParent: TFmxObject;
  ALeft, ATop, AWidth, AHeight: Single; AFillColor,
  AStrokeColor: TAlphaColor; ARadius: Single): TRectangle;
begin
  Result := TRectangle.Create(Self);
  Result.Parent := AParent;
  Result.Position.X := ALeft;
  Result.Position.Y := ATop;
  Result.Width := AWidth;
  Result.Height := AHeight;
  Result.XRadius := ARadius;
  Result.YRadius := ARadius;
  Result.Fill.Kind := TBrushKind.Solid;
  Result.Fill.Color := AFillColor;
  Result.Stroke.Kind := TBrushKind.Solid;
  Result.Stroke.Color := AStrokeColor;
  Result.HitTest := False;
end;

function TRickDialogProRuntimeForm.CreateActionButton(const ACaption: string;
  ALeft, AWidth: Single; ATag: NativeInt; AFillColor,
  ATextColor: TAlphaColor): TRectangle;
begin
  Result := CreateRectangle(FCard, ALeft, _BUTTON_TOP, AWidth,
    _BUTTON_HEIGHT, AFillColor, AFillColor, 14);

  Result.Tag := ATag;
  Result.Cursor := crHandPoint;
  Result.HitTest := True;
  Result.Stroke.Kind := TBrushKind.None;
  Result.OnClick := ButtonClick;
  Result.OnMouseEnter := ButtonMouseEnter;
  Result.OnMouseLeave := ButtonMouseLeave;

  CreateText(Result, ACaption, 0, 0, AWidth, _BUTTON_HEIGHT, 18, ATextColor,
    TTextAlign.Center, True);
end;

procedure TRickDialogProRuntimeForm.DrawIcon(AParent: TFmxObject);
var
  LIconData: TRickDialogProIconData; // Geometria SVG correspondente ao tipo atual.
  LPath: TPath;                   // Path FMX responsável pela renderização.
begin
  LIconData := TRickDialogProIcons.Resolve(FConfig.Kind);

  if Trim(LIconData.PathData) = EmptyStr then
    Exit;

  LPath := TPath.Create(Self);
  LPath.Parent := AParent;
  LPath.Position.X := _ICON_VECTOR_MARGIN;
  LPath.Position.Y := _ICON_VECTOR_MARGIN;
  LPath.Width := _ICON_VECTOR_SIZE;
  LPath.Height := _ICON_VECTOR_SIZE;
  LPath.HitTest := False;

  // TPath.Data recebe diretamente os comandos do atributo "d" do SVG.
  // O modo Fit mantém a proporção do desenho dentro da área disponível.
  LPath.WrapMode := TPathWrapMode.Fit;
  LPath.Data.Data := LIconData.PathData;

  // Os SVGs fornecidos são preenchidos. A geometria fica desacoplada da cor,
  // que continua sendo fornecida pelo tema visual ativo.
  LPath.Fill.Kind := TBrushKind.Solid;
  LPath.Fill.Color := FTheme.IconStroke(FConfig.Kind);
  LPath.Stroke.Kind := TBrushKind.None;
end;

procedure TRickDialogProRuntimeForm.ConfigureOverflowTooltips(
  AParent: TFmxObject);
var
  LIndex: Integer;      // Índice utilizado na inspeção recursiva.
  LChild: TFmxObject;   // Filho atualmente analisado.
  LLabel: TLabel;       // Label identificado durante a inspeção.
  LButton: TRectangle;  // Possível botão pai do label.
  LIsButtonText: Boolean;
begin
  if not Assigned(AParent) then
    Exit;

  for LIndex := 0 to AParent.ChildrenCount - 1 do
  begin
    LChild := AParent.Children[LIndex];

    if LChild is TLabel then
    begin
      LLabel := TLabel(LChild);
      LIsButtonText := False;

      // Labels internos dos botões permanecem com HitTest=False para que não
      // interceptem o clique. O tooltip desses captions é tratado pelo próprio
      // TRectangle no evento de hover do botão.
      if LLabel.Parent is TRectangle then
      begin
        LButton := TRectangle(LLabel.Parent);

        LIsButtonText :=
          (LButton.Tag = _TAG_PRIMARY) or
          (LButton.Tag = _TAG_SECONDARY);
      end;

      if not LIsButtonText then
      begin
        if IsTextOverflowing(LLabel) then
        begin
          LLabel.Cursor := crHelp;
          LLabel.HitTest := True;
          LLabel.OnMouseEnter := TextMouseEnter;
          LLabel.OnMouseLeave := TextMouseLeave;
        end
        else
        begin
          LLabel.HitTest := False;
        end;
      end;
    end;

    if LChild.ChildrenCount > 0 then
      ConfigureOverflowTooltips(LChild);
  end;
end;

function TRickDialogProRuntimeForm.MeasureTextSize(const AText: string;
  AFont: TFont; AMaxWidth: Single; AWordWrap: Boolean): TPointF;
var
  LLayout: TTextLayout; // Layout nativo utilizado somente para medição.
  LWidth: Single;       // Largura limite efetivamente utilizada.
begin
  Result := PointF(0, 0);

  if Trim(AText) = EmptyStr then
    Exit;

  if not Assigned(AFont) then
    Exit;

  LWidth := AMaxWidth;

  if LWidth <= 0 then
    LWidth := 1;

  LLayout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    LLayout.BeginUpdate;
    try
      LLayout.Text := AText;
      LLayout.Font.Assign(AFont);
      LLayout.WordWrap := AWordWrap;
      LLayout.HorizontalAlign := TTextAlign.Leading;
      LLayout.VerticalAlign := TTextAlign.Leading;

      if AWordWrap then
        LLayout.MaxSize := PointF(LWidth, 10000)
      else
        LLayout.MaxSize := PointF(10000, 10000);
    finally
      LLayout.EndUpdate;
    end;

    Result.X := LLayout.TextWidth;
    Result.Y := LLayout.TextHeight;
  finally
    LLayout.Free;
  end;
end;

function TRickDialogProRuntimeForm.IsTextOverflowing(
  ALabel: TLabel): Boolean;
var
  LTextSize: TPointF; // Área necessária para renderizar o conteúdo integral.
begin
  Result := False;

  if not Assigned(ALabel) then
    Exit;

  if Trim(ALabel.Text) = EmptyStr then
    Exit;

  LTextSize := MeasureTextSize(
    ALabel.Text,
    ALabel.TextSettings.Font,
    ALabel.Width,
    ALabel.WordWrap
  );

  if ALabel.WordWrap then
  begin
    Result :=
      LTextSize.Y > (ALabel.Height + _TEXT_OVERFLOW_TOLERANCE);
  end
  else
  begin
    Result :=
      (LTextSize.X > (ALabel.Width + _TEXT_OVERFLOW_TOLERANCE)) or
      (LTextSize.Y > (ALabel.Height + _TEXT_OVERFLOW_TOLERANCE));
  end;
end;

procedure TRickDialogProRuntimeForm.EnsureTextTooltip;
begin
  if Assigned(FTextTooltip) then
    Exit;

  FTextTooltip := TRectangle.Create(Self);
  FTextTooltip.Parent := FCard;
  FTextTooltip.Visible := False;
  FTextTooltip.HitTest := False;
  FTextTooltip.XRadius := _TOOLTIP_RADIUS;
  FTextTooltip.YRadius := _TOOLTIP_RADIUS;
  FTextTooltip.Fill.Kind := TBrushKind.Solid;
  FTextTooltip.Fill.Color := FTheme.SurfaceElevated;
  FTextTooltip.Stroke.Kind := TBrushKind.Solid;
  FTextTooltip.Stroke.Color := FTheme.Border;
  FTextTooltip.Stroke.Thickness := 1;

  FTextTooltipLabel := TLabel.Create(Self);
  FTextTooltipLabel.Parent := FTextTooltip;
  FTextTooltipLabel.HitTest := False;
  FTextTooltipLabel.AutoSize := False;
  FTextTooltipLabel.WordWrap := True;
  FTextTooltipLabel.TextSettings.Font.Size := _TOOLTIP_FONT_SIZE;
  FTextTooltipLabel.TextSettings.FontColor := FTheme.TextPrimary;
  FTextTooltipLabel.TextSettings.HorzAlign := TTextAlign.Leading;
  FTextTooltipLabel.TextSettings.VertAlign := TTextAlign.Leading;
  FTextTooltipLabel.StyledSettings :=
    FTextTooltipLabel.StyledSettings -
    [
      TStyledSetting.Size,
      TStyledSetting.FontColor
    ];
end;

procedure TRickDialogProRuntimeForm.ShowTextTooltip(ALabel: TLabel);
var
  LTextSize: TPointF;       // Tamanho calculado para o texto completo.
  LTooltipWidth: Single;    // Largura final do balão.
  LTooltipHeight: Single;   // Altura final do balão.
  LTextWidth: Single;       // Largura útil interna do balão.
  LTargetTopLeft: TPointF;  // Posição do label relativa ao card.
  LTargetBottom: TPointF;   // Limite inferior do label relativo ao card.
  LLeft: Single;            // Posição horizontal final do balão.
  LTop: Single;             // Posição vertical final do balão.
begin
  if not Assigned(ALabel) then
    Exit;

  if not IsTextOverflowing(ALabel) then
    Exit;

  EnsureTextTooltip;

  FTextTooltipLabel.Text := ALabel.Text;

  LTextWidth := _TOOLTIP_MAX_WIDTH - (_TOOLTIP_PADDING * 2);

  LTextSize := MeasureTextSize(
    FTextTooltipLabel.Text,
    FTextTooltipLabel.TextSettings.Font,
    LTextWidth,
    True
  );

  LTooltipWidth := LTextSize.X + (_TOOLTIP_PADDING * 2);

  if LTooltipWidth < _TOOLTIP_MIN_WIDTH then
    LTooltipWidth := _TOOLTIP_MIN_WIDTH;

  if LTooltipWidth > _TOOLTIP_MAX_WIDTH then
    LTooltipWidth := _TOOLTIP_MAX_WIDTH;

  // Mede novamente utilizando a largura definitiva do balão. Isso garante
  // que a altura corresponda exatamente às quebras de linha que serão
  // renderizadas.
  LTextWidth := LTooltipWidth - (_TOOLTIP_PADDING * 2);

  LTextSize := MeasureTextSize(
    FTextTooltipLabel.Text,
    FTextTooltipLabel.TextSettings.Font,
    LTextWidth,
    True
  );

  LTooltipHeight := LTextSize.Y + (_TOOLTIP_PADDING * 2);

  if LTooltipHeight < _TOOLTIP_MIN_HEIGHT then
    LTooltipHeight := _TOOLTIP_MIN_HEIGHT;

  // LocalToAbsolute/AbsoluteToLocal permite que o mesmo mecanismo continue
  // válido caso novos textos sejam criados em containers internos.
  LTargetTopLeft := FCard.AbsoluteToLocal(
    ALabel.LocalToAbsolute(PointF(0, 0))
  );

  LTargetBottom := FCard.AbsoluteToLocal(
    ALabel.LocalToAbsolute(PointF(0, ALabel.Height))
  );

  LLeft := LTargetTopLeft.X;
  LTop := LTargetBottom.Y + _TOOLTIP_GAP;

  // Mantém o balão dentro da lateral direita do card.
  if (LLeft + LTooltipWidth) >
     (FCard.Width - _TOOLTIP_MARGIN) then
  begin
    LLeft :=
      FCard.Width -
      _TOOLTIP_MARGIN -
      LTooltipWidth;
  end;

  if LLeft < _TOOLTIP_MARGIN then
    LLeft := _TOOLTIP_MARGIN;

  // Quando não existe espaço suficiente abaixo do texto, o balão é
  // apresentado acima do componente de origem.
  if (LTop + LTooltipHeight) >
     (FCard.Height - _TOOLTIP_MARGIN) then
  begin
    LTop :=
      LTargetTopLeft.Y -
      _TOOLTIP_GAP -
      LTooltipHeight;
  end;

  if LTop < _TOOLTIP_MARGIN then
    LTop := _TOOLTIP_MARGIN;

  FTextTooltip.Position.X := LLeft;
  FTextTooltip.Position.Y := LTop;
  FTextTooltip.Width := LTooltipWidth;
  FTextTooltip.Height := LTooltipHeight;

  FTextTooltipLabel.Position.X := _TOOLTIP_PADDING;
  FTextTooltipLabel.Position.Y := _TOOLTIP_PADDING;
  FTextTooltipLabel.Width :=
    LTooltipWidth - (_TOOLTIP_PADDING * 2);
  FTextTooltipLabel.Height :=
    LTooltipHeight - (_TOOLTIP_PADDING * 2);

  FTextTooltip.BringToFront;
  FTextTooltip.Visible := True;
end;

procedure TRickDialogProRuntimeForm.HideTextTooltip;
begin
  if not Assigned(FTextTooltip) then
    Exit;

  FTextTooltip.Visible := False;
end;

procedure TRickDialogProRuntimeForm.TextMouseEnter(Sender: TObject);
begin
  if not(Sender is TLabel) then
    Exit;

  ShowTextTooltip(TLabel(Sender));
end;

procedure TRickDialogProRuntimeForm.TextMouseLeave(Sender: TObject);
begin
  HideTextTooltip;
end;

procedure TRickDialogProRuntimeForm.ShowButtonTextTooltip(
  AButton: TRectangle);
var
  LIndex: Integer;    // Índice utilizado na inspeção dos filhos do botão.
  LChild: TFmxObject; // Filho atualmente analisado.
begin
  if not Assigned(AButton) then
    Exit;

  for LIndex := 0 to AButton.ChildrenCount - 1 do
  begin
    LChild := AButton.Children[LIndex];

    if LChild is TLabel then
    begin
      if IsTextOverflowing(TLabel(LChild)) then
        ShowTextTooltip(TLabel(LChild));

      Exit;
    end;
  end;
end;

procedure TRickDialogProRuntimeForm.ButtonClick(Sender: TObject);
begin
  if not (Sender is TRectangle) then
    Exit;

  case TRectangle(Sender).Tag of
    _TAG_PRIMARY:
      FResult := TRickDialogProResult.Primary;

    _TAG_SECONDARY:
      FResult := TRickDialogProResult.Secondary;
  else
    Exit;
  end;

  ModalResult := mrOk;
end;

procedure TRickDialogProRuntimeForm.ButtonMouseEnter(Sender: TObject);
var
  LButton: TRectangle; // Botão atualmente apontado pelo mouse.
begin
  if not(Sender is TRectangle) then
    Exit;

  LButton := TRectangle(Sender);

  case LButton.Tag of
    _TAG_PRIMARY:
      LButton.Fill.Color :=
        FTheme.PrimaryButtonHoverBackground(FConfig.Kind);

    _TAG_SECONDARY:
      LButton.Fill.Color :=
        FTheme.SecondaryButtonHoverBackground;
  end;

  ShowButtonTextTooltip(LButton);
end;

procedure TRickDialogProRuntimeForm.ButtonMouseLeave(Sender: TObject);
var
  LButton: TRectangle; // Botão que deixou de ser apontado pelo mouse.
begin
  if not(Sender is TRectangle) then
    Exit;

  LButton := TRectangle(Sender);

  case LButton.Tag of
    _TAG_PRIMARY:
      LButton.Fill.Color :=
        FTheme.PrimaryButtonBackground(FConfig.Kind);

    _TAG_SECONDARY:
      LButton.Fill.Color :=
        FTheme.SecondaryButtonBackground;
  end;

  HideTextTooltip;
end;

function TRickDialogProRuntimeForm.Execute: TRickDialogProResult;
begin
  ShowModal;
  Result := FResult;
end;

end.
