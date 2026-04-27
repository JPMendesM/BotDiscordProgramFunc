defmodule Bot.Command.Ppt do
  @valid_choices ["pedra", "papel", "tesoura"]

  def handle_ppt(msg) do
    case msg.content |> String.trim() |> String.split(" ") do
      ["!ppt"] ->
        "✋ Use o comando: !ppt <pedra | papel | tesoura>\n✊ Pedra | ✋ Papel | ✌️ Tesoura"

      ["!ppt", player_choice] when player_choice in @valid_choices ->
        play_game(player_choice)

      _ ->
        "❌ Comando inválido.\nUse: !ppt <pedra | papel | tesoura>"
    end
  end

  defp play_game(player_choice) do
    bot_choice = Enum.random(@valid_choices)
    result = get_result(player_choice, bot_choice)

    build_message(result, player_choice, bot_choice)
  end

  defp get_result(choice, choice), do: :empate
  defp get_result("pedra", "tesoura"), do: :vitoria
  defp get_result("papel", "pedra"), do: :vitoria
  defp get_result("tesoura", "papel"), do: :vitoria
  defp get_result(_, _), do: :derrota

  defp emoji("pedra"), do: "✊"
  defp emoji("papel"), do: "✋"
  defp emoji("tesoura"), do: "✌️"

  defp build_message(:empate, player, bot),
    do: "🤝 EMPATE!\nVocê: #{emoji(player)} #{player}\nBot: #{emoji(bot)} #{bot}"

  defp build_message(:vitoria, player, bot),
    do: "🎉 VOCÊ GANHOU!\nVocê: #{emoji(player)} #{player}\nBot: #{emoji(bot)} #{bot}"

  defp build_message(:derrota, player, bot),
    do: "💀 EU GANHEI!\nVocê: #{emoji(player)} #{player}\nBot: #{emoji(bot)} #{bot}"
end
