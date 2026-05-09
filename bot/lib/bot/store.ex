defmodule Bot.Store do
  @file_path "data/lembretes.json"

  def add_lembrete(user_id, texto) do
    user_id = to_string(user_id)

    dados = read_data()

    lembretes_atuais = Map.get(dados, user_id, [])

    novos_dados =
      Map.put(dados, user_id, lembretes_atuais ++ [texto])

    write_data(novos_dados)
  end

  def get_lembretes(user_id) do
    user_id = to_string(user_id)

    dados = read_data()

    Map.get(dados, user_id, [])
  end

  defp read_data do
    case File.read(@file_path) do
      {:ok, content} ->
        case Jason.decode(content) do
          {:ok, dados} -> dados
          _ -> %{}
        end

      {:error, _} ->
        %{}
    end
  end

  defp write_data(dados) do
    File.mkdir_p!("data")

    json = Jason.encode!(dados, pretty: true)

    File.write!(@file_path, json)

    :ok
  end

  def delete_lembrete(user_id, index) do
    user_id = to_string(user_id)

    dados = read_data()

    lembretes = Map.get(dados, user_id, [])

    if index < 0 or index >= length(lembretes) do
      {:error, :invalid_index}
    else
      novos_lembretes = List.delete_at(lembretes, index)

      novos_dados =
        Map.put(dados, user_id, novos_lembretes)

      write_data(novos_dados)

      {:ok, novos_lembretes}
    end
  end
end
