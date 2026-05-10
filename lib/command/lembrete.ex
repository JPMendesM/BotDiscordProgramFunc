defmodule Bot.Command.Lembrete do
  def handle_lembrar(msg) do
    case String.split(msg.content, " ", parts: 2) do
      ["!lembrar"] ->
        "Use o comando como: !lembrar <texto>"

      ["!lembrar", texto] ->
        texto = String.trim(texto)

        if texto == "" do
          "❌ Você precisa informar o que deseja lembrar."
        else
          Bot.Store.add_lembrete(msg.author.id, texto)
          "✅ Anotado! Vou lembrar disso."
        end

      _ ->
        "Comando inválido. Use: !lembrar <texto>"
    end
  end

  def handle_lembretes(msg) do
    lembretes = Bot.Store.get_lembretes(msg.author.id)

    if Enum.empty?(lembretes) do
      "📭 Você ainda não tem lembretes salvos."
    else
      lista =
        lembretes
        |> Enum.with_index(1)
        |> Enum.map(fn {lembrete, index} -> "#{index}. #{lembrete}" end)
        |> Enum.join("\n")

      """
      📌 Seus lembretes:

      #{lista}
      """
    end
  end

  def handle_apagar(msg) do
    case String.split(msg.content, " ", parts: 2) do
      ["!apagarlb"] ->
        "Use o comando como: !apagarlb <numero>"

      ["!apagarlb", numero] ->
        case Integer.parse(numero) do
          {index, ""} ->
            case Bot.Store.delete_lembrete(msg.author.id, index - 1) do
              {:ok, _} ->
                "🗑️ Lembrete apagado com sucesso!"

              {:error, :invalid_index} ->
                "❌ Número inválido."
            end

          _ ->
            "❌ Informe um número válido."
        end

      _ ->
        "Comando inválido."
    end
  end
end
