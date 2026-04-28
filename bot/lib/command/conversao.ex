defmodule Bot.Command.Conversao do
  def handle_converter(msg) do
    # Removido o 'parts: 2' para permitir separar em 4 palavras
    case msg.content |> String.trim() |> String.split(" ") do
      ["!conv"] ->
        "Use o comando como: !conv <valor> <DE> <PARA>"

      ["!conv", valor, de, para] ->
        converter_moeda(valor, String.upcase(de), String.upcase(para))

      ["!conv", "moedas"] ->
        listar_moedas()

      _ ->
        "Formato inválido! Use: `!conv <valor> <DE> <PARA>` (Ex: !conv 100 USD BRL)"
    end
  end

  defp converter_moeda(valor_str, de, para) do
    api_key = Application.get_env(:bot, :exchange_api_key)
    url = "https://v6.exchangerate-api.com/v6/#{api_key}/pair/#{de}/#{para}"

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        data = Jason.decode!(body)
        taxa = data["conversion_rate"]

        case Float.parse(valor_str) do
          {valor, _} ->
            resultado = valor * taxa

            "💰 **Conversão:** #{valor} #{de} equivale a **#{Float.round(resultado, 2)} #{para}** (Taxa: #{taxa})"

          :error ->
            "❌ Valor numérico inválido."
        end

      {:ok, %{status_code: 404}} ->
        "❌ Moeda não encontrada."

      _ ->
        "⚠️ Erro ao acessar a API de câmbio."
    end
  end
end
