defmodule Bot.Command.Rota do
  def handle_rota(msg) do
    case String.split(msg.content, " ", parts: 2) do
      ["!rota"] ->
        "Use o comando como: !rota <origem>; <destino>"

      ["!rota", texto] ->
        case String.split(texto, ";", parts: 2) do
          [origem, destino] ->
            buscar_rota(String.trim(origem), String.trim(destino))

          _ ->
            "❌ Use o formato correto: !rota Fortaleza; São Paulo"
        end

      _ ->
        "Comando inválido."
    end
  end

  defp buscar_rota(origem, destino) do
    with {:ok, coord_origem} <- buscar_coordenadas(origem),
         {:ok, coord_destino} <- buscar_coordenadas(destino),
         {:ok, rota} <- calcular_rota(coord_origem, coord_destino) do
      distancia_km = Float.round(rota["distance"] / 1000, 2)
      duracao_min = Float.round(rota["duration"] / 60, 1)

      """
      🧭 Rota encontrada

      📍 Origem: #{origem}
      🏁 Destino: #{destino}

      🛣️ Distância aproximada: #{distancia_km} km
      ⏱️ Tempo estimado: #{duracao_min} minutos
      """
    else
      {:error, mensagem} -> mensagem
    end
  end

  defp buscar_coordenadas(cidade) do
    url =
      "https://nominatim.openstreetmap.org/search?q=#{URI.encode(cidade)}&format=json&limit=1"

    headers = [{"User-Agent", "BotDiscordElixir/1.0"}]

    case HTTPoison.get(url, headers) do
      {:ok, response} ->
        case Jason.decode(response.body) do
          {:ok, [local | _]} ->
            {:ok, %{lat: local["lat"], lon: local["lon"]}}

          _ ->
            {:error, "❌ Não encontrei a cidade: #{cidade}"}
        end

      _ ->
        {:error, "❌ Erro ao consultar coordenadas de #{cidade}."}
    end
  end

  defp calcular_rota(origem, destino) do
    url =
      "https://router.project-osrm.org/route/v1/driving/#{origem.lon},#{origem.lat};#{destino.lon},#{destino.lat}?overview=false"

    case HTTPoison.get(url) do
      {:ok, response} ->
        case Jason.decode(response.body) do
          {:ok, %{"routes" => [rota | _]}} ->
            {:ok, rota}

          _ ->
            {:error, "❌ Não foi possível calcular a rota."}
        end

      _ ->
        {:error, "❌ Erro ao consultar a rota."}
    end
  end
end
