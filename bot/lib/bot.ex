defmodule Bot do
  use Nostrum.Consumer

  alias Nostrum.Api.Message

  def handle_event({:MESSAGE_CREATE, msg, _ws}) do
    cond do
      String.starts_with?(msg.content, "!ping") ->
        Message.create(msg.channel_id, "pong!")

      String.starts_with?(msg.content, "!ppt") ->
        Message.create(msg.channel_id, Bot.Command.Ppt.handle_ppt(msg))

      String.starts_with?(msg.content, "!cep") ->
        Message.create(msg.channel_id, Bot.Command.Cep.handle_cep(msg))

      String.starts_with?(msg.content, "!dog") ->
        Message.create(msg.channel_id, Bot.Command.Animal.handle_dog(msg))

      String.starts_with?(msg.content, "!cat") ->
        Message.create(msg.channel_id, Bot.Command.Animal.handle_cat(msg))

      String.starts_with?(msg.content, "!clima") ->
        Message.create(msg.channel_id, Bot.Command.Clima.handle_clima(msg))

      String.starts_with?(msg.content, "!conv") ->
        Message.create(msg.channel_id, Bot.Command.Conversao.handle_converter(msg))

      String.starts_with?(msg.content, "!lembrar") ->
        Message.create(msg.channel_id, Bot.Command.Lembrete.handle_lembrar(msg))

      String.starts_with?(msg.content, "!lembretes") ->
        Message.create(msg.channel_id, Bot.Command.Lembrete.handle_lembretes(msg))

      String.starts_with?(msg.content, "!apagarlb") ->
        Message.create(msg.channel_id, Bot.Command.Lembrete.handle_apagar(msg))

      String.starts_with?(msg.content, "!curiosidade") ->
        Message.create(msg.channel_id, Bot.Command.Curiosidade.handle_curiosidade(msg))

      String.starts_with?(msg.content, "!ddd") ->
        Message.create(msg.channel_id, Bot.Command.Ddd.handle_ddd(msg))

      String.starts_with?(msg.content, "!rota") ->
        Message.create(msg.channel_id, Bot.Command.Rota.handle_rota(msg))

      true ->
        :ignore
    end
  end
end
