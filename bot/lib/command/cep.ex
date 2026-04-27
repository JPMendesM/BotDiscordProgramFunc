defmodule Bot.Command.Cep do

  def handle_cep(msg) do
    case msg.content |> String.trim() |> String.split(" ") do
      ["!cep"] ->
        "Use o comando como: !cep <numero>"

      ["!cep", number] ->
        create_response(number)

      _ ->
        "Comando inválido"
    end
  end

  defp create_response(number) do
    url = "https://viacep.com.br/ws/#{number}/json/"

    case HTTPoison.get(url) do
      {:ok, response} ->
        case Jason.decode(response.body) do
          {:ok, json} ->
            if Map.get(json, "erro") do
              "❌ CEP inválido, tente novamente!"
            else
              """
              📮 CEP: #{json["cep"]}
              📍 #{json["logradouro"]} #{json["complemento"]}
              🏘️ Bairro: #{json["bairro"]}
              🏙️ Cidade: #{json["localidade"]} - #{json["uf"]}
              🌎 Estado: #{json["estado"]} (#{json["regiao"]})
              📞 DDD: #{json["ddd"]}
              """
            end

          _ ->
            "Erro ao processar resposta do servidor."
        end

      _ ->
        "Erro ao consultar o CEP."
    end
  end

end
