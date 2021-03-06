# encoding: utf-8

# Helpers for the telegram bot commands
module CommandHelper
  def get_commands(json:)
    commands = [Command::Start, Command::ConvertSpeech, Command::ChangeLang]
    answer_commands = commands
    correct_commands = []

    command = json['message']
    command = command['text'] unless command.nil?
    unless command.nil?
      commands.each do |c|
        next unless c.command?(command, bot_name: settings.bot_username)

        correct_commands << c.new(json: json, helpers: self)
        # Remove from commands which can potentially be answered
        # because this is already a command for this command class
        answer_commands -= [c]
      end
    end

    # Commands which can answer this non-command
    answer_commands.each do |c|
      if c.can_answer?(json: json, bot_name: settings.bot_username)
        correct_commands << c.new(json: json, helpers: self)
      end
    end

    # Get context, if any and set context commands
    chat_id = json['message']
    chat_id = chat_id['chat'] unless chat_id.nil?
    chat_id = chat_id['id'] unless chat_id.nil?
    context = read_context(chat_id: chat_id)
    unless context.nil?
      commands.each do |c|
        next unless c.context?(context)
        comm = c.new(json: json, helpers: self)
        comm.context = true
        correct_commands << comm
      end
    end

    correct_commands
  end
end
