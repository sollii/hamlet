class ChatBot
  constructor: (@chat, @modules) ->
    @poster = POSTER_CONSTANTS.bot

  respondTo: (message) ->
    @perform(message.route)

  perform: (interaction_route) ->
    interaction = @modules.getInteraction(interaction_route)
    for message in interaction.bot_messages
      @chat.postMessage(message, @poster)
    if interaction.user_actions
      @chat.renderUserActions(interaction.user_actions)

window.ChatBot = ChatBot
