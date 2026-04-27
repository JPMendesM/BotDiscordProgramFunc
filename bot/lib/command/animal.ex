defmodule Bot.Command.Animal do

  def handle_dog(msg) do
    if msg.content == "!dog" do
      {:ok, response} = HTTPoison.get("https://dog.ceo/api/breeds/image/random")
      {:ok, json} = Jason.decode(response.body)
      json["message"]

    end
  end

def handle_cat(_msg) do
  case HTTPoison.get("https://api.thecatapi.com/v1/images/search") do
    {:ok, response} ->
      case Jason.decode(response.body) do
        {:ok, [cat | _]} ->
          cat["url"]

        _ ->
          "Erro ao processar imagem 🐱"
      end

    _ ->
      "Erro ao buscar gato 🐱"
  end
end

end
