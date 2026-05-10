defmodule Bot.Command.Comparar do
  def handle_comparar(msg) do
    case String.split(msg.content, " ", trim: true) do
      ["!comparar"] ->
        "Use o comando como: !comparar <pokemon1> <pokemon2>"

      ["!comparar", pokemon1, pokemon2] ->
        comparar_pokemons(pokemon1, pokemon2)

      _ ->
        "❌ Use o comando como: !comparar <pokemon1> <pokemon2>"
    end
  end

  defp comparar_pokemons(pokemon1, pokemon2) do
    with {:ok, p1} <- buscar_pokemon(pokemon1),
         {:ok, p2} <- buscar_pokemon(pokemon2) do
      tipos1 = formatar_tipos(p1)
      tipos2 = formatar_tipos(p2)

      """
      ⚔️ Comparação Pokémon

      🔹 #{String.capitalize(p1["name"])}
      🧬 Tipo(s): #{tipos1}
      📏 Altura: #{p1["height"]}
      ⚖️ Peso: #{p1["weight"]}
      ⭐ XP Base: #{p1["base_experience"]}

      ----------------------------

      🔹 #{String.capitalize(p2["name"])}
      🧬 Tipo(s): #{tipos2}
      📏 Altura: #{p2["height"]}
      ⚖️ Peso: #{p2["weight"]}
      ⭐ XP Base: #{p2["base_experience"]}
      """
    else
      {:error, mensagem} -> mensagem
    end
  end

  defp buscar_pokemon(nome) do
    url = "https://pokeapi.co/api/v2/pokemon/#{String.downcase(nome)}"

    case HTTPoison.get(url) do
      {:ok, response} ->
        case Jason.decode(response.body) do
          {:ok, %{"name" => _} = json} ->
            {:ok, json}

          _ ->
            {:error, "❌ Pokémon não encontrado: #{nome}"}
        end

      _ ->
        {:error, "❌ Erro ao consultar a PokéAPI."}
    end
  end

  defp formatar_tipos(pokemon) do
    pokemon["types"]
    |> Enum.map(fn tipo -> tipo["type"]["name"] end)
    |> Enum.join(", ")
  end
end
