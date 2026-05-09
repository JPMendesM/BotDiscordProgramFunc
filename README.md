# Bot Discord em Elixir

Bot desenvolvido em Elixir utilizando a biblioteca Nostrum para interação com o Discord.

## Requisitos

- Elixir instalado
- Erlang/OTP instalado
- Conta no Discord Developer Portal
- Token do bot Discord

## Configuração do Token

Antes de executar o bot, é necessário configurar o token do Discord.

No terminal, dentro da pasta do projeto, execute:

```bash
set DISCORD_TOKEN=SEU_TOKEN_AQUI
```

No PowerShell:

```powershell
$env:DISCORD_TOKEN="SEU_TOKEN_AQUI"
```

Não compartilhe o token do bot publicamente.

## Instalação das dependências

Execute:

```bash
mix deps.get
```

## Execução do bot

Para iniciar o bot, execute:

```bash
mix run --no-halt
```

## Comandos disponíveis

```text
!ping
!ppt <pedra|papel|tesoura>
!cep <numero>
!dog
!cat
!gemini <pergunta>
!clima <cidade>
!conv <valor> <moeda_origem> <moeda_destino>
!lembrar <texto>
!lembretes
!apagar <numero>
!curiosidade <cidade>
!ddd <numero>
!rota <origem>; <destino>
```

## Persistência JSON

O comando de lembretes utiliza persistência local em arquivo JSON.

Arquivo utilizado:

```text
data/lembretes.json
```

Exemplo:

```text
!lembrar estudar Elixir
!lembretes
!apagar 1
```

## Estrutura do Projeto

```text
lib/
├── bot.ex
└── bot/
    ├── application.ex
    ├── store.ex
    └── command/
        ├── animal.ex
        ├── cep.ex
        ├── clima.ex
        ├── comparacao.ex
        ├── conversao.ex
        ├── curiosidade.ex
        ├── ddd.ex
        ├── gemini.ex
        ├── lembrete.ex
        ├── ppt.ex
        └── rota.ex
```

## APIs utilizadas

- ViaCEP
- BrasilAPI
- Wikipedia/Wikimedia API
- OpenStreetMap Nominatim
- OSRM
- APIs de animais
- API de clima
- API de conversão de moedas
- PokéAPI

## Observação

Cada comando foi organizado em um módulo separado para manter o código mais limpo, modular e fácil de manter.