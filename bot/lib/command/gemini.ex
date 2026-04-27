defmodule Bot.Command.Gemini do

  def handle_gemini(msg) do

    case msg.content |> String.trim() |> String.split(" ", parts: 2) do
      ["!gemini"] ->
        "Use o comando como: !gemini <sua mensagem/prompt aqui>"

      ["!gemini", prompt] ->
        create_response(prompt)

      _ ->
        "Comando inválido"
    end
  end

  defp create_response(prompt) do
    url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=AIzaSyDLHk93z78KHeiGrC5jQfEYhzDH17lFv0s"

    body = Jason.encode!(%{
      contents: [%{parts: [%{text: prompt}]}]
    })

    case HTTPoison.post(url, body, [{"Content-Type", "application/json"}]) do
      {:ok, response} ->
        case Jason.decode(response.body) do
          {:ok, json} ->
            if Map.has_key?(json, "error") do
              "❌ Tive um problema com a API: #{json["error"]["message"]}"
            else
              json["candidates"]
              |> List.first()
              |> get_in(["content", "parts"])
              |> List.first()
              |> Map.get("text")
              |> String.slice(0, 1900)
            end

          _ ->
            "Erro ao processar a resposta do Gemini 🤖"
        end

      _ ->
        "Erro ao conectar com o Gemini 🤖"
    end
  end

end
