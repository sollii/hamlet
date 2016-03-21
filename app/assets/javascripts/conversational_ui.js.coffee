#= require_tree ./conversation_modules



class Chat
  constructor: (message_container_selector, actions_container_selector) ->
    @messages_container = $(message_container_selector)
    @actions_container = $(actions_container_selector)

  addChatBot: (@chat_bot) ->

  postMessage: (message, poster) ->
    message = createMessageObject(message, @)
    @messages_container.append(message.render())
    if poster == POSTER_CONSTANTS.user
      @chat_bot.respondTo(message)

  startTyping: (poster) ->

  stopTyping: (poster) ->

  renderUserActions: (actions) ->
    actions = createActionsObject(actions, @)
    @actions_container.append(actions.render())

  finishAction: ->
    @actions_container.empty()

class ChatBot
  constructor: (@chat) ->
    @poster = POSTER_CONSTANTS.bot

  respondTo: (message) ->
    @perform(message.route)

  perform: (interaction_route) ->
    interaction = getInteraction(interaction_route)
    for message in interaction.bot_messages
      @chat.postMessage(message, @poster)
    if interaction.user_actions
      @chat.renderUserActions(interaction.user_actions)


class Message
  constructor: (data, @chat) ->
    @text = data.text
    @action = data.action
    @route = data.route

  parseText: (text) ->
    text.replace /#{(.*?)}/g, (match, p1) -> eval(p1)

  render: ->
    $("<div class='chat-message'>#{@parseText(@text)}</div>")

class UserAction
  constructor: (data, @chat) ->
    @poster = POSTER_CONSTANTS.user
    @action = data.action

  trigger: ->
    ActionDispatcher.dispatch(@action, "hi") if @action
    @chat.finishAction()
    @chat.postMessage(@message, @poster)

  render: ->

class UserActionButton extends UserAction
  constructor: (data, @chat) ->
    super(data, @chat)
    @text = data.text
    @message = {type: "message", text: @text, route: data.route}

  render: ->
    $button = $("<div style='color: blue'>#{@text}</div>")
    $button.click => @trigger()
    return $button

class TextButtons
  constructor: (data, @chat) ->
    @buttons = data.buttons

  render: ->
    $buttons_container = $("<div>")
    for button in @buttons
      button = new UserActionButton(button, @chat)
      $buttons_container.append(button.render())
    return $buttons_container

ActionDispatcher = {
  dispatch: (action, payload) ->
    console.log @actions
    @actions[action](payload)
  actions: {
    "UPDATE_NAME": (payload) -> console.log payload
  }
}

message_types = {
  "message": Message
}

action_types = {
  "text_buttons": TextButtons,
  "text_button": UserActionButton
}

conversation_modules = {
  "onboarding": onboarding
}

POSTER_CONSTANTS = {
  user: "user",
  bot: "bot"
}

getInteraction = (route) ->
  [module, interaction] = route.split("/")
  onboarding[interaction]

createMessageObject = (message, chat) ->
  MessageObject = message_types[message.type]
  new MessageObject(message, chat)

createActionsObject = (actions, chat) ->
  ActionsObject = action_types[actions.type]
  new ActionsObject(actions, chat)

window.Chat = Chat
window.ChatBot = ChatBot





