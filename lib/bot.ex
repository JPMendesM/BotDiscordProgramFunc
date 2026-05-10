defmodule Bot do
  use Nostrum.Consumer

  alias Nostrum.Api.Message

  def handle_event({:MESSAGE_CREATE, msg, _ws}) do
    partes =
      msg.content
      |> String.trim()
      |> String.split(" ", trim: true)

    handle_command(partes, msg)
  end

  def handle_event(_event), do: :ignore

  defp handle_command(["!ping"], msg) do
    Message.create(msg.channel_id, "pong!")
  end

  defp handle_command(["!ppt" | _], msg) do
    Message.create(msg.channel_id, Bot.Command.Ppt.handle_ppt(msg))
  end

  defp handle_command(["!cep" | _], msg) do
    Message.create(msg.channel_id, Bot.Command.Cep.handle_cep(msg))
  end

  defp handle_command(["!dog"], msg) do
    Message.create(msg.channel_id, Bot.Command.Animal.handle_dog(msg))
  end

  defp handle_command(["!cat"], msg) do
    Message.create(msg.channel_id, Bot.Command.Animal.handle_cat(msg))
  end

  defp handle_command(["!clima" | _], msg) do
    Message.create(msg.channel_id, Bot.Command.Clima.handle_clima(msg))
  end

  defp handle_command(["!conv" | _], msg) do
    Message.create(msg.channel_id, Bot.Command.Conversao.handle_converter(msg))
  end

  defp handle_command(["!lembrar" | _], msg) do
    Message.create(msg.channel_id, Bot.Command.Lembrete.handle_lembrar(msg))
  end

  defp handle_command(["!lembretes"], msg) do
    Message.create(msg.channel_id, Bot.Command.Lembrete.handle_lembretes(msg))
  end

  defp handle_command(["!apagarlb" | _], msg) do
    Message.create(msg.channel_id, Bot.Command.Lembrete.handle_apagar(msg))
  end

  defp handle_command(["!curiosidade" | _], msg) do
    Message.create(msg.channel_id, Bot.Command.Curiosidade.handle_curiosidade(msg))
  end

  defp handle_command(["!ddd" | _], msg) do
    Message.create(msg.channel_id, Bot.Command.Ddd.handle_ddd(msg))
  end

  defp handle_command(["!rota" | _], msg) do
    Message.create(msg.channel_id, Bot.Command.Rota.handle_rota(msg))
  end

  defp handle_command(["!comparar" | _], msg) do
    Message.create(msg.channel_id, Bot.Command.Comparar.handle_comparar(msg))
  end

  defp handle_command(_, _msg) do
    :ignore
  end
end
