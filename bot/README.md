# Bot Discord em Elixir

Bot desenvolvido em Elixir utilizando a biblioteca Nostrum para integração com o Discord.

## Requisitos

- Elixir instalado
- Erlang/OTP instalado
- Conta no Discord Developer Portal
- Token do bot Discord

## Configuração

O projeto utiliza um arquivo de exemplo para configuração.

Copie o arquivo:

```bash
config/config.example.exs
```

para:

```bash
config/config.exs
```

e preencha suas chaves e token do Discord.

## Instalação das dependências

Execute:

```bash
mix deps.get
```

## Execução do bot

Execute:

```bash
mix run --no-halt
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
        ├── comparar.ex
        ├── conversao.ex
        ├── curiosidade.ex
        ├── ddd.ex
        ├── lembrete.ex
        ├── ppt.ex
        └── rota.ex
```

## Comandos obrigatórios

```text
!dog
!cep <numero>
!ddd <numero>
!conv <valor> <moeda_origem> <moeda_destino>
!comparar <pokemon1> <pokemon2>
!lembrar <texto>
!lembretes
!curiosidade <cidade>

```

## Comandos extras

```text
!cat
!clima <cidade>
!rota <origem>; <destino>
!ppt <pedra|papel|tesoura>
!apagar <numero>
```

## Persistência JSON

O sistema de lembretes utiliza persistência em JSON local através do módulo `Bot.Store`.

Arquivo utilizado:

```text
data/lembretes.json
```

Exemplos:

```text
!lembrar estudar Elixir
!lembretes
!apagar 1
```

## APIs Utilizadas

- The Dog API
- ViaCEP
- BrasilAPI
- ExchangeRate API
- PokéAPI
- Wikimedia API
- Wikipedia API
- OpenWeather API
- OpenStreetMap Nominatim
- OSRM API

## Conceitos utilizados

- Pattern Matching
- Pipe Operator (`|>`)
- Enum
- Map
- GenServer
- Supervisor
- Persistência JSON
- Consumo de APIs REST
- Modularização

## Observação

O projeto foi desenvolvido utilizando programação funcional em Elixir com organização modular e separação de responsabilidades entre Consumer, Commands e Store.