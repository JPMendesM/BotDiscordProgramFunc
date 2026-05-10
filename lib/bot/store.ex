defmodule Bot.Store do
  use GenServer

  @file_path "data/lembretes.json"

  # Client API

  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def add_lembrete(user_id, texto) do
    GenServer.call(__MODULE__, {:add_lembrete, to_string(user_id), texto})
  end

  def get_lembretes(user_id) do
    GenServer.call(__MODULE__, {:get_lembretes, to_string(user_id)})
  end

  def delete_lembrete(user_id, index) do
    GenServer.call(__MODULE__, {:delete_lembrete, to_string(user_id), index})
  end

  # Server callbacks

  @impl true
  def init(_state) do
    dados = read_data()
    {:ok, dados}
  end

  @impl true
  def handle_call({:add_lembrete, user_id, texto}, _from, dados) do
    lembretes_atuais = Map.get(dados, user_id, [])

    novos_dados =
      Map.put(dados, user_id, lembretes_atuais ++ [texto])

    write_data(novos_dados)

    {:reply, :ok, novos_dados}
  end

  @impl true
  def handle_call({:get_lembretes, user_id}, _from, dados) do
    lembretes = Map.get(dados, user_id, [])

    {:reply, lembretes, dados}
  end

  @impl true
  def handle_call({:delete_lembrete, user_id, index}, _from, dados) do
    lembretes = Map.get(dados, user_id, [])

    if index < 0 or index >= length(lembretes) do
      {:reply, {:error, :invalid_index}, dados}
    else
      novos_lembretes = List.delete_at(lembretes, index)

      novos_dados =
        Map.put(dados, user_id, novos_lembretes)

      write_data(novos_dados)

      {:reply, {:ok, novos_lembretes}, novos_dados}
    end
  end

  # Funções auxiliares

  defp read_data do
    File.mkdir_p!("data")

    case File.read(@file_path) do
      {:ok, content} ->
        case Jason.decode(content) do
          {:ok, dados} -> dados
          _ -> %{}
        end

      {:error, _} ->
        write_data(%{})
        %{}
    end
  end

  defp write_data(dados) do
    File.mkdir_p!("data")

    json = Jason.encode!(dados, pretty: true)

    File.write!(@file_path, json)

    :ok
  end
end
