# RickDialogPro — Guia de Uso

Este guia documenta a superfície pública de uso atualmente suportada pelo código-fonte do RickDialogPro.

> [!IMPORTANT]
> O código consumidor deve utilizar a unit pública `Rick.Dialog.Pro`. Units sob `Rick.Dialog.Pro.Impl.*` são detalhes de implementação e não são necessárias para o consumo normal.

## 1. API pública

A fachada pública é disponibilizada por:

```delphi
uses
  Rick.Dialog.Pro;
```

A fachada disponibiliza os principais contratos e tipos públicos:

- `TRickDialogPro`
- `IRickDialogPro`
- `IRickDialogProTheme`
- `TRickDialogProKind`
- `TRickDialogProResult`
- `TRickDialogProConfig`

Uma instância pode ser criada com o tema padrão:

```delphi
var
  LDialog: IRickDialogPro;
begin
  LDialog := TRickDialogPro.New;
end;
```

Ou com um tema customizado que implemente `IRickDialogProTheme`:

```delphi
LDialog := TRickDialogPro.New(LTheme);
```

## 2. Utilizando a estrutura atual dos fontes

O repositório atual inclui um exemplo FireMonkey em `sample/`.

Quando o framework é referenciado diretamente pela estrutura atual dos fontes, esse exemplo utiliza estes diretórios no Search Path do Delphi:

```text
src
src\Impl
src\Theme
```

Esses caminhos descrevem a organização atual do repositório. Eles não constituem uma definição para toda possível forma futura de distribuição.

## 3. Mantendo uma instância do diálogo

O exemplo incluído no repositório mantém uma referência `IRickDialogPro` no formulário:

```delphi
private
  FDialog: IRickDialogPro;
```

e cria a instância na inicialização do formulário:

```delphi
procedure TPageMain.FormCreate(Sender: TObject);
begin
  FDialog := TRickDialogPro.New;
end;
```

A referência de interface pode então ser reutilizada em várias chamadas de diálogo.

## 4. Information

**Comportamento comprovado:** `Information` faz parte do contrato atual de `IRickDialogPro`. Sua caption principal padrão é `Entendi`, e a caption secundária padrão é uma string vazia.

```delphi
var
  LResult: TRickDialogProResult;
begin
  LResult := FDialog.Information(
    'Informação',
    'Os dados foram atualizados.'
  );
end;
```

Também é possível informar uma caption principal personalizada:

```delphi
FDialog.Information(
  'Informação',
  'Os dados foram atualizados.',
  'OK'
);
```

## 5. Success

**Comportamento comprovado:** `Success` faz parte do contrato atual. Sua caption principal padrão é `Concluir`.

```delphi
FDialog.Success(
  'Sucesso',
  'A operação foi concluída.'
);
```

Com uma caption personalizada:

```delphi
FDialog.Success(
  'Sucesso',
  'A operação foi concluída.',
  'Fechar'
);
```

## 6. Warning

**Comportamento comprovado:** `Warning` faz parte do contrato atual. Sua caption principal padrão é `Entendi`.

```delphi
FDialog.Warning(
  'Atenção',
  'Revise os dados antes de continuar.'
);
```

Também pode apresentar uma ação secundária:

```delphi
FDialog.Warning(
  'Confirmação',
  'Deseja continuar?',
  'Continuar',
  'Cancelar'
);
```

## 7. Error

**Comportamento comprovado:** `Error` faz parte do contrato atual. Sua caption principal padrão é `Fechar`.

```delphi
FDialog.Error(
  'Erro',
  'Não foi possível concluir a operação.'
);
```

Com captions personalizadas:

```delphi
FDialog.Error(
  'Erro',
  'Não foi possível concluir a operação.',
  'Tentar novamente',
  'Fechar'
);
```

## 8. Captions de ação personalizadas

Os métodos semânticos aceitam os seguintes argumentos:

```text
Title
MessageText
PrimaryCaption
SecondaryCaption
```

`PrimaryCaption` e `SecondaryCaption` permitem que a aplicação consumidora defina os textos apresentados ao usuário.

Exemplo:

```delphi
FDialog.Warning(
  'Excluir item',
  'Deseja excluir o item selecionado?',
  'Excluir',
  'Manter'
);
```

As captions descrevem a apresentação. O significado de negócio de cada resultado continua pertencendo à aplicação consumidora.

## 9. Tratando resultados

O tipo público de resultado é:

```delphi
TRickDialogProResult = (
  None,
  Primary,
  Secondary
);
```

### Primary e Secondary

**Comportamento comprovado:** clicar na ação principal registra `Primary`; clicar na ação secundária registra `Secondary`.

```delphi
var
  LResult: TRickDialogProResult;
begin
  LResult := FDialog.Warning(
    'Confirmação',
    'Deseja continuar?',
    'Continuar',
    'Cancelar'
  );

  case LResult of
    TRickDialogProResult.Primary:
      begin
        { Ação principal definida pela aplicação. }
      end;

    TRickDialogProResult.Secondary:
      begin
        { Ação secundária definida pela aplicação. }
      end;

    TRickDialogProResult.None:
      begin
        { Nenhuma ação Primary ou Secondary foi registrada. }
      end;
  end;
end;
```

### None

**Comportamento comprovado:** o diálogo runtime inicializa seu resultado como `None`. O valor é alterado somente quando uma ação principal ou secundária reconhecida é registrada, e `Execute` retorna o resultado atual após o término da interação modal.

Portanto, a afirmação suportada é:

> `None` significa que nenhuma ação `Primary` ou `Secondary` foi registrada antes do término da execução modal.

O código atual **não** permite atribuir a `None` um mecanismo específico de fechamento. Por isso, este guia não afirma, por exemplo, que `None` signifique especificamente Escape, fechamento da janela ou qualquer outra ação particular.

## 10. Regras de negócio permanecem na aplicação

O RickDialogPro retorna qual ação foi selecionada. Ele não executa regras de negócio da aplicação.

Exemplo:

```delphi
var
  LResult: TRickDialogProResult;
begin
  LResult := FDialog.Warning(
    'Excluir registro',
    'Deseja excluir este registro?',
    'Excluir',
    'Cancelar'
  );

  case LResult of
    TRickDialogProResult.Primary:
      DeleteRecord;

    TRickDialogProResult.Secondary:
      Exit;
  end;
end;
```

Nesse exemplo, `DeleteRecord` pertence à aplicação consumidora. O RickDialogPro apenas informa a ação selecionada.

`Primary` não significa universalmente "Sim", e `Secondary` não significa universalmente "Cancelar". O significado de negócio depende das captions e do código consumidor.

## 11. Execute com TRickDialogProConfig

Além dos quatro métodos semânticos, `IRickDialogPro` disponibiliza:

```delphi
function Execute(
  const AConfig: TRickDialogProConfig
): TRickDialogProResult;
```

Uma configuração pode ser criada com um dos builders existentes:

```delphi
var
  LConfig: TRickDialogProConfig;
  LResult: TRickDialogProResult;
begin
  LConfig := TRickDialogProConfig.Warning(
    'Confirmação',
    'Deseja continuar?',
    'Continuar',
    'Cancelar'
  );

  LResult := FDialog.Execute(LConfig);
end;
```

Isso é útil quando a aplicação precisa preparar a configuração antes de exibir o diálogo.

## 12. Builders de configuração

`TRickDialogProConfig` disponibiliza atualmente estes builders:

```delphi
TRickDialogProConfig.Error(...)
TRickDialogProConfig.Warning(...)
TRickDialogProConfig.Information(...)
TRickDialogProConfig.Success(...)
```

**Comportamento comprovado:** cada builder:

1. começa em `TRickDialogProConfig.Default`;
2. aplica a semântica solicitada;
3. atribui título, mensagem e captions;
4. define `ShowSecondary` de acordo com a existência de conteúdo na caption secundária após `Trim`;
5. preserva `UseBackground` como `False`, conforme `TRickDialogProConfig.Default`.

Exemplo:

```delphi
LConfig := TRickDialogProConfig.Success(
  'Concluído',
  'A operação foi finalizada com sucesso.',
  'Finalizar'
);
```

Quando a caption secundária é omitida ou fica vazia após `Trim`, o builder define `ShowSecondary` como `False`.

## 13. Configuração manual

A configuração manual é possível porque o record de configuração expõe seus campos publicamente.

A configuração padrão é:

| Campo | Valor padrão atual |
|---|---|
| `Kind` | `Information` |
| `Title` | vazio |
| `MessageText` | vazio |
| `PrimaryCaption` | `Entendi` |
| `SecondaryCaption` | vazio |
| `ShowSecondary` | `False` |
| `UseBackground` | `False` |

Exemplo com uma ação:

```delphi
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Default;

  LConfig.Kind := TRickDialogProKind.Information;
  LConfig.Title := 'Informação';
  LConfig.MessageText := 'O processo está pronto.';
  LConfig.PrimaryCaption := 'OK';

  FDialog.Execute(LConfig);
end;
```

Exemplo com uma ação secundária:

```delphi
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Default;

  LConfig.Kind := TRickDialogProKind.Warning;
  LConfig.Title := 'Confirmação';
  LConfig.MessageText := 'Deseja continuar?';
  LConfig.PrimaryCaption := 'Sim';
  LConfig.SecondaryCaption := 'Não';
  LConfig.ShowSecondary := True;

  FDialog.Execute(LConfig);
end;
```

> [!IMPORTANT]
> **Comportamento comprovado:** na implementação runtime atual, o botão secundário é criado somente quando `ShowSecondary` é `True` **e** `SecondaryCaption` não fica vazia após `Trim`.
>
> Ao montar a configuração manualmente, mantenha os dois valores consistentes. Os builders existentes já calculam `ShowSecondary` a partir da caption secundária.

### Utilizando o Background do tema

**Comportamento comprovado:** `UseBackground` é `False` por padrão. Quando permanece desabilitado, a RuntimeForm mantém o comportamento atual de `Fill.Color` transparente. Quando `UseBackground` é `True`, a RuntimeForm atribui `IRickDialogProTheme.Background` a `Fill.Color` do formulário host.

```delphi
var
  LConfig: TRickDialogProConfig;
begin
  LConfig := TRickDialogProConfig.Information(
    'Informação',
    'O formulário host utilizará o Background fornecido pelo tema.'
  );

  LConfig.UseBackground := True;

  FDialog.Execute(LConfig);
end;
```

Os atalhos `Error`, `Warning`, `Information` e `Success` continuam utilizando o comportamento padrão, pois os builders partem de `TRickDialogProConfig.Default`, onde `UseBackground` é `False`. Para habilitar o background do tema na API atual, utilize `TRickDialogProConfig` e `Execute`.

> [!NOTE]
> O código atual comprova que, quando habilitado, `FTheme.Background` é atribuído a `Fill.Color` da RuntimeForm. Como `Transparency` permanece `True`, este guia não afirma efeitos visuais adicionais além dessa atribuição sem validação visual específica.

## 14. Tooltips para textos com overflow

A implementação runtime verifica os textos depois que a interface do diálogo foi montada. Quando um label não cabe na área reservada para ele, o RickDialogPro habilita um tooltip no hover com o conteúdo completo.

Esse comportamento se aplica aos textos que o runtime efetivamente renderiza, incluindo título, mensagem com quebra de linha e captions das ações. Nos botões, o tooltip é tratado pelo hover do próprio botão, de forma que o label interno não intercepte o clique.

O tooltip também utiliza o tema ativo: `SurfaceElevated` fornece a cor da superfície, `Border` fornece o contorno e `TextPrimary` fornece a cor do texto. Ele é exibido no hover somente quando o texto correspondente é identificado como excedendo a área disponível e é ocultado quando o ponteiro deixa o elemento.

> [!NOTE]
> O overflow é determinado a partir das métricas reais de texto utilizadas pelo FireMonkey. Por isso, este guia não fixa quantidade de caracteres, largura em pixels, posição do tooltip ou número de linhas, pois esses detalhes dependem da medição e da renderização do texto.

## 15. Temas personalizados

A fachada pública aceita um `IRickDialogProTheme` customizado:

```delphi
FDialog := TRickDialogPro.New(LTheme);
```

Um tema customizado deve implementar integralmente a interface atual.

### Exemplo ilustrativo

> [!NOTE]
> Os valores de cores abaixo são **apenas ilustrativos**. O objetivo é demonstrar a implementação do contrato público de tema e sua injeção em `TRickDialogPro.New`. Eles não constituem uma paleta obrigatória ou recomendada pelo RickDialogPro.

```delphi
uses
  Rick.Dialog.Pro,
  System.UITypes;

type
  TMyDialogTheme = class(TInterfacedObject, IRickDialogProTheme)
  public
    function Background: TAlphaColor;
    function Surface: TAlphaColor;
    function SurfaceElevated: TAlphaColor;
    function Border: TAlphaColor;
    function TextPrimary: TAlphaColor;
    function TextSecondary: TAlphaColor;

    function StatusColor(
      AKind: TRickDialogProKind
    ): TAlphaColor;

    function IconBackground(
      AKind: TRickDialogProKind
    ): TAlphaColor;

    function IconStroke(
      AKind: TRickDialogProKind
    ): TAlphaColor;

    function PrimaryButtonBackground(
      AKind: TRickDialogProKind
    ): TAlphaColor;

    function PrimaryButtonHoverBackground(
      AKind: TRickDialogProKind
    ): TAlphaColor;

    function PrimaryButtonText(
      AKind: TRickDialogProKind
    ): TAlphaColor;

    function SecondaryButtonBackground: TAlphaColor;
    function SecondaryButtonHoverBackground: TAlphaColor;
    function SecondaryButtonText: TAlphaColor;
  end;

function TMyDialogTheme.Background: TAlphaColor;
begin
  Result := TAlphaColor($FF101418);
end;

function TMyDialogTheme.Surface: TAlphaColor;
begin
  Result := TAlphaColor($FF1C2228);
end;

function TMyDialogTheme.SurfaceElevated: TAlphaColor;
begin
  Result := TAlphaColor($FF252D35);
end;

function TMyDialogTheme.Border: TAlphaColor;
begin
  Result := TAlphaColor($FF3A4652);
end;

function TMyDialogTheme.TextPrimary: TAlphaColor;
begin
  Result := TAlphaColor($FFF5F7FA);
end;

function TMyDialogTheme.TextSecondary: TAlphaColor;
begin
  Result := TAlphaColor($FFB5C0CB);
end;

function TMyDialogTheme.StatusColor(
  AKind: TRickDialogProKind
): TAlphaColor;
begin
  case AKind of
    TRickDialogProKind.Error:
      Result := TAlphaColor($FFE05252);

    TRickDialogProKind.Warning:
      Result := TAlphaColor($FFE0A52B);

    TRickDialogProKind.Information:
      Result := TAlphaColor($FF4C9BE8);

    TRickDialogProKind.Success:
      Result := TAlphaColor($FF42A66B);
  else
    Result := TAlphaColor($FF4C9BE8);
  end;
end;

function TMyDialogTheme.IconBackground(
  AKind: TRickDialogProKind
): TAlphaColor;
begin
  Result := StatusColor(AKind);
end;

function TMyDialogTheme.IconStroke(
  AKind: TRickDialogProKind
): TAlphaColor;
begin
  Result := TAlphaColor($FFFFFFFF);
end;

function TMyDialogTheme.PrimaryButtonBackground(
  AKind: TRickDialogProKind
): TAlphaColor;
begin
  Result := StatusColor(AKind);
end;

function TMyDialogTheme.PrimaryButtonHoverBackground(
  AKind: TRickDialogProKind
): TAlphaColor;
begin
  Result := StatusColor(AKind);
end;

function TMyDialogTheme.PrimaryButtonText(
  AKind: TRickDialogProKind
): TAlphaColor;
begin
  Result := TAlphaColor($FFFFFFFF);
end;

function TMyDialogTheme.SecondaryButtonBackground: TAlphaColor;
begin
  Result := TAlphaColor($FF303942);
end;

function TMyDialogTheme.SecondaryButtonHoverBackground: TAlphaColor;
begin
  Result := TAlphaColor($FF3B4651);
end;

function TMyDialogTheme.SecondaryButtonText: TAlphaColor;
begin
  Result := TAlphaColor($FFF5F7FA);
end;
```

O tema pode então ser injetado pela fachada pública:

```delphi
var
  LTheme: IRickDialogProTheme;
begin
  LTheme := TMyDialogTheme.Create;
  FDialog := TRickDialogPro.New(LTheme);
end;
```

A sobrecarga que recebe um tema espera uma implementação válida de `IRickDialogProTheme`. Informar `nil` não faz fallback para o tema padrão; a implementação FMX atual lança `EArgumentNilException`. Quando a intenção for utilizar o tema padrão, use `TRickDialogPro.New` sem argumentos.

### Background e `UseBackground`

`Background` faz parte do contrato atual de `IRickDialogProTheme` e deve ser implementado por um tema customizado.

**Comportamento comprovado:** a RuntimeForm consulta `IRickDialogProTheme.Background` somente quando `TRickDialogProConfig.UseBackground` é `True`. Quando `UseBackground` permanece `False`, o comportamento padrão continua utilizando `Fill.Color` transparente.

A ativação é feita pela configuração do diálogo, e não por um parâmetro adicional nos métodos `Error`, `Warning`, `Information` ou `Success`.

> [!NOTE]
> Na implementação atual, `Transparency` permanece `True`. A documentação, portanto, descreve de forma estrita a atribuição de `Background` a `Fill.Color` quando habilitado e não presume um resultado visual além do que foi validado pelo código.

### Como o runtime consome o tema

O contrato de tema possui responsabilidades visuais concretas no renderer atual. Isso é especialmente útil ao criar um tema customizado, porque cada método controla uma parte efetiva da interface e não apenas um ponto de extensão futuro.

| Método do tema | Responsabilidade atual no runtime |
|---|---|
| `Background` | `Fill.Color` do formulário host quando `UseBackground = True` |
| `Surface` | Superfície do card principal do diálogo |
| `SurfaceElevated` | Superfície do tooltip de overflow |
| `Border` | Borda do card principal e borda do tooltip de overflow |
| `TextPrimary` | Título do diálogo e texto do tooltip de overflow |
| `TextSecondary` | Texto da mensagem do diálogo |
| `StatusColor(AKind)` | Linha semântica na borda superior do card |
| `IconBackground(AKind)` | Círculo de fundo do ícone semântico |
| `IconStroke(AKind)` | Cor do ícone vetorial |
| `PrimaryButtonBackground(AKind)` | Fundo normal do botão principal |
| `PrimaryButtonHoverBackground(AKind)` | Fundo do botão principal durante o hover |
| `PrimaryButtonText(AKind)` | Texto do botão principal |
| `SecondaryButtonBackground` | Fundo normal do botão secundário |
| `SecondaryButtonHoverBackground` | Fundo do botão secundário durante o hover |
| `SecondaryButtonText` | Texto do botão secundário |

### Tipo semântico e resolução do tema

`TRickDialogProKind` não funciona apenas como uma informação descritiva. O renderer atual passa o tipo selecionado ao tema ao resolver a linha semântica superior, as cores do ícone e as cores do botão principal. Assim, `Error`, `Warning`, `Information` e `Success` podem compartilhar o mesmo layout e ainda apresentar identidades semânticas diferentes.

Os métodos do botão secundário não recebem `TRickDialogProKind` no contrato público atual. Portanto, sua aparência é definida de forma global pelo tema, e não por tipo semântico.

## 16. Exemplo do repositório

O exemplo FireMonkey em `sample/` demonstra o consumo básico e a seleção em tempo de execução entre três temas:

- `Default`, que permanece como tema inicial e é criado com `TRickDialogPro.New`;
- `Light`, implementado por `TRickDialogProSampleLightTheme`;
- `Green`, implementado por `TRickDialogProSampleGreenTheme`.

`Light` e `Green` pertencem ao projeto de exemplo. Eles demonstram como uma aplicação consumidora pode implementar `IRickDialogProTheme` sem alterar o tema padrão ou a API pública do framework.

O formulário mantém:

```delphi
FDialog: IRickDialogPro;
```

e inicia com:

```delphi
FDialog := TRickDialogPro.New;
```

Após selecionar `Light` ou `Green` e clicar em `Apply`, o exemplo recria `FDialog` utilizando a sobrecarga existente que recebe o tema:

```delphi
FDialog := TRickDialogPro.New(TRickDialogProSampleLightTheme.New);
// ou
FDialog := TRickDialogPro.New(TRickDialogProSampleGreenTheme.New);
```

Ao selecionar `Default` e clicar em `Apply`, a fachada é recriada sem argumento de tema, retornando ao tema padrão do framework. Os quatro helpers semânticos continuam sendo chamados pelo mesmo contrato público:

```delphi
FDialog.Error(...);
FDialog.Warning(...);
FDialog.Information(...);
FDialog.Success(...);
```

O exemplo não comprova que todas as capacidades da API possuem cobertura visual dedicada, e os temas do exemplo não fazem parte da suíte automatizada de regressão do framework.

## 17. Referência rápida da API

### TRickDialogPro

```delphi
class function New: IRickDialogPro; overload; static;

class function New(
  const ATheme: IRickDialogProTheme
): IRickDialogPro; overload; static;
```

### IRickDialogPro

```delphi
function Execute(
  const AConfig: TRickDialogProConfig
): TRickDialogProResult;

function Error(
  const ATitle: string;
  const AMessageText: string;
  const APrimaryCaption: string = 'Fechar';
  const ASecondaryCaption: string = ''
): TRickDialogProResult;

function Warning(
  const ATitle: string;
  const AMessageText: string;
  const APrimaryCaption: string = 'Entendi';
  const ASecondaryCaption: string = ''
): TRickDialogProResult;

function Information(
  const ATitle: string;
  const AMessageText: string;
  const APrimaryCaption: string = 'Entendi';
  const ASecondaryCaption: string = ''
): TRickDialogProResult;

function Success(
  const ATitle: string;
  const AMessageText: string;
  const APrimaryCaption: string = 'Concluir';
  const ASecondaryCaption: string = ''
): TRickDialogProResult;
```

### TRickDialogProKind

```delphi
TRickDialogProKind = (
  Error,
  Warning,
  Information,
  Success
);
```

### TRickDialogProResult

```delphi
TRickDialogProResult = (
  None,
  Primary,
  Secondary
);
```

### TRickDialogProConfig

Campos públicos:

```delphi
Kind: TRickDialogProKind;
Title: string;
MessageText: string;
PrimaryCaption: string;
SecondaryCaption: string;
ShowSecondary: Boolean;
UseBackground: Boolean;
```

Builders disponíveis:

```delphi
TRickDialogProConfig.Default
TRickDialogProConfig.Error(...)
TRickDialogProConfig.Warning(...)
TRickDialogProConfig.Information(...)
TRickDialogProConfig.Success(...)
```

## 18. Testes automatizados de regressão

O repositório inclui um projeto DUnitX em `tests/RickDialogPro.Tests.dproj`, integrado ao `RickDialog.groupproj`. A suíte cobre os builders públicos de configuração e os ícones, o tema padrão, a RuntimeForm, o uso de background, cores semânticas, botões primário e secundário, hover, tooltips de overflow, resultados modais e fluxos end-to-end pela fachada pública.

O código-fonte atual contém **48 declarações `[Test]`**. O runner de console está configurado para adicionar um logger XML compatível com NUnit por meio de `TDUnitX.Options.XMLOutputFile`, mas o pacote de projeto revisado não contém um artefato persistido com o resultado DUnitX.

O projeto de testes habilita atualmente **Win32** como plataforma alvo. Por isso, um resultado atual de execução para esse target deverá ser registrado no quality gate de build/testes antes da versão estável. Este guia não estende qualquer afirmação de validação para Win64, Android, iOS ou macOS.

Esses testes protegem comportamento determinístico. Eles não devem ser interpretados como certificação visual pixel-perfect entre plataformas, fontes, configurações de DPI ou diferenças de renderização do sistema operacional.

## 19. Notas da implementação atual

As seguintes distinções são intencionais neste guia:

- **Comportamento comprovado** é afirmado diretamente quando está sustentado pelo código atual.
- **Exemplos ilustrativos** são identificados explicitamente quando valores são escolhidos somente para demonstrar o uso da API.
- **Cuidados da implementação atual** são declarados explicitamente quando a documentação precisa limitar uma afirmação ao que o código realmente comprova.

Comportamento atual relevante:

- `TRickDialogProConfig.UseBackground` é `False` por padrão.
- Quando `UseBackground = True`, a RuntimeForm atribui `IRickDialogProTheme.Background` a `Fill.Color`.
- `Transparency` permanece `True`; por isso, o guia não extrapola a descrição para efeitos visuais não validados.
- `TRickDialogPro.New(ATheme)` exige um tema diferente de `nil`; a implementação não substitui silenciosamente pelo tema padrão.
- Os tooltips de overflow são habilitados somente quando o runtime detecta que o texto renderizado não cabe na área disponível.
- O código-fonte declara 48 testes DUnitX e o projeto de testes está configurado para Win32; o pacote de projeto revisado não inclui um artefato persistido com o resultado da execução.

Afirmações sobre outros targets ou sobre a renderização visual devem ser adicionadas somente depois que essas plataformas forem efetivamente validadas.
