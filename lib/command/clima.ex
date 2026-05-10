defmodule Bot.Command.Clima do
  def handle_clima(msg) do
    case msg.content |> String.trim() |> String.split(" ", parts: 2) do
      ["!clima"] ->
        "Use o comando como: !clima <cidade>"

      ["!clima", cidade] ->
        search_weather(cidade)

      _ ->
        "Comando inválido"
    end
  end

  def search_weather(cidade) do
      api_key = Application.get_env(:bot, :weather_api_key)

    url =
      "https://api.openweathermap.org/data/2.5/weather?q=#{URI.encode(cidade)}&appid=#{api_key}&units=metric&lang=pt_br"

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        data = Jason.decode!(body)

        temp = data["main"]["temp"]
        sensacao = data["main"]["feels_like"]
        umidade = data["main"]["humidity"]
        descricao = data["weather"] |> List.first() |> Map.get("description")
        cidade_nome = data["name"]

        """
        🌍 **Clima em #{cidade_nome}**
        ☁️ **Condição:** #{descricao}
        🌡️ **Temperatura:** #{temp}°C
        🔥 **Sensação Térmica:** #{sensacao}°C
        💧 **Umidade:** #{umidade}%
        """

      {:ok, %{status_code: 404}} ->
        "❌ Cidade não encontrada."

      _ ->
        "⚠️ Erro ao consultar a API de clima."
    end
  end
end
