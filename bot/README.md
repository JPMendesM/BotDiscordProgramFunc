# Bot Discord em Elixir

Bot desenvolvido em Elixir utilizando o framework Nostrum para integração com o Discord.

O projeto implementa múltiplos comandos consumindo APIs REST distintas, além de persistência de dados em JSON local utilizando GenServer e Supervisor seguindo os conceitos de OTP.

---

# Requisitos

- Elixir instalado
- Erlang/OTP instalado
- Conta no Discord Developer Portal
- Token do bot Discord

---

# Configuração

O projeto utiliza um arquivo de exemplo para configuração.

Copie o arquivo:

```bash
config/config.example.exs
```

para:

```bash
config/config.exs
```

e configure:

- Token do bot Discord;
- Chaves das APIs utilizadas.

---

# Instalação das Dependências

Execute:

```bash
mix deps.get
```

---

# Execução do Bot

Execute:

```bash
mix run --no-halt
```

---

# Estrutura do Projeto

```text
lib/
├── bot.ex
├── bot/
│   ├── application.ex
│   └── store.ex
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

---

# Comandos Obrigatórios

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

---

# Comandos Extras

```text
!cat
!clima <cidade>
!rota <origem>; <destino>
!ppt <pedra|papel|tesoura>
!apagar <numero>
```

---

# Persistência JSON

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

---

# APIs Utilizadas

- The Dog API
- ViaCEP
- BrasilAPI
- OpenWeather API
- ExchangeRate API
- PokéAPI
- Wikimedia API
- Wikipedia API
- OpenStreetMap Nominatim
- OSRM API

---

# Conceitos Utilizados

- Programação Funcional
- Pattern Matching
- Pipe Operator (`|>`)
- Enum
- Map
- GenServer
- Supervisor
- Persistência JSON
- Consumo de APIs REST
- Modularização

---

# Observação

O projeto foi desenvolvido utilizando programação funcional em Elixir com organização modular e separação de responsabilidades entre Consumer, Commands e Store.