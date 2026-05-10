defmodule Bot.Command.Ddd do

  def handle_ddd(msg) do
    case msg.content |> String.trim() |> String.split(" ") do
      ["!ddd"] ->
        "Use o comando como: !ddd <numero>"

      ["!ddd", ddd] ->
        buscar_ddd(ddd)

      _ ->
        "Comando inválido."
    end
  end

  defp buscar_ddd(ddd) do
    url = "https://brasilapi.com.br/api/ddd/v1/#{ddd}"

    case HTTPoison.get(url) do
      {:ok, response} ->
        case Jason.decode(response.body) do
          {:ok, json} ->

            if Map.get(json, "state") == nil do
              "❌ DDD não encontrado."
            else
              cidades =
                json["cities"]
                |> Enum.take(10)
                |> Enum.join(", ")

              """
              📞 DDD: #{ddd}

              🗺️ Estado: #{json["state"]}

              🏙️ Algumas cidades:
              #{cidades}
              """
            end

          _ ->
            "Erro ao processar resposta."
        end

      _ ->
        "Erro ao consultar API."
    end
  end
end
