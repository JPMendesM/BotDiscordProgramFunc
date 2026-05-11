# Bot Discord em Elixir

Aplicação desenvolvida em Elixir utilizando o framework Nostrum para integração com o Discord.

Projeto desenvolvido para a disciplina de Programação Funcional utilizando os conceitos de:

- Pattern Matching
- Pipe Operator (`|>`)
- GenServer
- Supervisor OTP
- Persistência JSON
- Consumo de APIs REST
- Organização modular
- Programação Funcional

---

# Funcionalidades

O bot permite:

- Consultar CEPs
- Consultar DDDs
- Consultar clima
- Converter moedas
- Comparar Pokémons
- Buscar curiosidades sobre cidades
- Calcular rotas
- Gerenciar lembretes
- Persistência em arquivo JSON
- Jogos simples via comando

---

# Estrutura do Projeto

```txt
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

config/
data/
test/
mix.exs
mix.lock
README.md
```

## Responsabilidades

### Bot
Responsável pelo Consumer principal do Discord e despacho de comandos utilizando pattern matching.

### Bot.Application
Responsável pela inicialização supervisionada da aplicação utilizando Supervisor OTP.

### Bot.Store
Responsável pela persistência dos lembretes em arquivo JSON utilizando GenServer.

### Bot.Command
Responsável pela implementação individual de cada comando do bot.

---

# Dependências

- Elixir
- Erlang/OTP
- Nostrum
- HTTPoison
- Jason

---

# Configuração

Copie o arquivo:

```bash
config/config.example.exs
```

para:

```bash
config/config.exs
```

e configure:

- Token do Discord;
- Chaves das APIs utilizadas.

---

# Instalação

Clone o repositório:

```bash
git clone https://github.com/JPMendesM/BotDiscordProgramFunc.git
```

Entre na pasta do projeto:

```bash
cd BotDiscordProgramFunc
```

Instale as dependências:

```bash
mix deps.get
```

---

# Execução

Execute o projeto com:

```bash
mix run --no-halt
```

---

# Comandos

## Comandos Obrigatórios

### Consulta de CEP

```txt
!cep 60700000
```

### Consulta de DDD

```txt
!ddd 85
```

### Conversão de moedas

```txt
!conv 100 USD BRL
```

### Comparação de Pokémons

```txt
!comparar pikachu charizard
```

### Persistência JSON

```txt
!lembrar estudar elixir
!lembretes
!apagar 1
```

### Curiosidades sobre cidades

```txt
!curiosidade fortaleza
```

---

## Comandos Extras

### Imagem aleatória de cachorro

```txt
!dog
```

### Imagem aleatória de gato

```txt
!cat
```

### Consulta de clima

```txt
!clima fortaleza
```

### Cálculo de rota

```txt
!rota fortaleza; sobral
```

### Pedra, papel e tesoura

```txt
!ppt pedra
```

---

# Persistência de Dados

Os lembretes são armazenados no arquivo:

```txt
data/lembretes.json
```

A leitura ocorre durante a inicialização da aplicação através do módulo `Bot.Store`, e o salvamento é realizado automaticamente após operações de escrita.

---

# APIs Utilizadas

| API | Função |
|---|---|
| The Dog API | Imagens de cachorro |
| ViaCEP | Consulta de CEP |
| BrasilAPI | Consulta de DDD |
| OpenWeather API | Consulta climática |
| ExchangeRate API | Conversão de moedas |
| PokéAPI | Comparação de Pokémons |
| Wikimedia API | Busca de curiosidades |
| Wikipedia API | Resumo de cidades |
| OpenStreetMap Nominatim | Coordenadas geográficas |
| OSRM API | Cálculo de rotas |

---

# Conceitos Utilizados

## Pattern Matching

O despacho dos comandos foi implementado utilizando pattern matching em cláusulas de função.

Exemplo:

```elixir
defp handle_command(["!cep" | _], msg) do
```

## GenServer

O módulo `Bot.Store` utiliza GenServer para gerenciamento do estado compartilhado dos lembretes.

## Supervisor OTP

A aplicação utiliza Supervisor para inicialização supervisionada dos processos principais.

## Persistência JSON

Os lembretes são serializados em JSON utilizando a biblioteca Jason.

## Pipe Operator

O operador `|>` foi utilizado para encadeamento de transformações de dados.

---

# Autor

João Pedro Mendes Moreira