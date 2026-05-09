defmodule Bot.Command.Curiosidade do
  def handle_curiosidade(msg) do
    case String.split(msg.content, " ", parts: 2) do
      ["!curiosidade"] ->
        "Use o comando como: !curiosidade <cidade>"

      ["!curiosidade", cidade] ->
        cidade
        |> String.trim()
        |> buscar_titulo()
        |> buscar_resumo()

      _ ->
        "Comando inválido. Use: !curiosidade <cidade>"
    end
  end

  defp buscar_titulo(cidade) do
    url =
      "https://api.wikimedia.org/core/v1/wikipedia/pt/search/page?q=#{URI.encode(cidade)}&limit=1"

    case HTTPoison.get(url) do
      {:ok, response} ->
        case Jason.decode(response.body) do
          {:ok, json} ->
            pages = json["pages"]

            if pages == [] or is_nil(pages) do
              {:error, "❌ Não encontrei nenhuma curiosidade sobre essa cidade."}
            else
              titulo = List.first(pages)["title"]
              {:ok, titulo}
            end

          _ ->
            {:error, "❌ Erro ao processar a busca da cidade."}
        end

      _ ->
        {:error, "❌ Erro ao consultar a primeira API."}
    end
  end

  defp buscar_resumo({:error, mensagem}), do: mensagem

  defp buscar_resumo({:ok, titulo}) do
    url =
      "https://pt.wikipedia.org/api/rest_v1/page/summary/#{URI.encode(titulo)}"

    case HTTPoison.get(url) do
      {:ok, response} ->
        case Jason.decode(response.body) do
          {:ok, json} ->
            resumo = json["extract"]
            link = json["content_urls"]["desktop"]["page"]

            if is_nil(resumo) do
              "❌ Não consegui encontrar um resumo sobre #{titulo}."
            else
              """
              🏙️ Curiosidade sobre #{titulo}

              #{resumo}

              🔗 Fonte: #{link}
              """
            end

          _ ->
            "❌ Erro ao processar a segunda API."
        end

      _ ->
        "❌ Erro ao consultar a segunda API."
    end
  end
end
