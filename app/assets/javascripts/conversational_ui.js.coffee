class Chat
  constructor: (message_container_selector, actions_container_selector) ->
    @messages_container = $(message_container_selector)
    @actions_container = $(actions_container_selector)
    @typing_speed = 500
    @reading_speed = 500
    @message_queue = []
    @typing = false

  addChatBot: (@chat_bot) ->

  postMessage: (message, poster) ->
    if poster == POSTER_CONSTANTS.bot
      @addToQueue [message, poster]
    else
      @animateUserPost(message, poster)

  addToQueue: (item) ->
    @message_queue.push item
    if not @typing
      @typing = true
      @animatePostMessage()

  animatePostMessage: ->
    if @message_queue.length > 0
      [message, poster] = @message_queue.pop()
      @startTyping(poster)
      setTimeout (=>
        @stopTyping(poster)
        @postMessageHelper(message, poster)
        @animatePostMessage()
      ), @typing_speed
    else
      @typing = false

  animateUserPost: (message, poster) ->
    message = createMessageObject(message, @, poster)
    $message = $("<div class='message-item #{poster} hide' />").append(message.render())
    @messages_container.append($message)
    setTimeout (-> $message.removeClass("hide")), 50
    setTimeout (=> @chat_bot.respondTo(message)), @reading_speed


  postMessageHelper: (message, poster) ->
    message = createMessageObject(message, @, poster)
    $message = $("<div class='message-item #{poster}' />").append(message.render())
    @messages_container.append($message)

  startTyping: (poster) ->
    if poster == POSTER_CONSTANTS.bot
      $("#bot-typing").show()

  stopTyping: (poster) ->
    $("#bot-typing").hide()

  renderUserActions: (actions) ->
    actions = createActionsObject(actions, @)
    @actions_container.append(actions.render())
    actions.componentDidMount()

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
  constructor: (data, @chat, @poster) ->
    @text = data.text
    @action = data.action
    @route = data.route

  parseText: (text) ->
    text.replace /#{(.*?)}/g, (match, p1) -> eval(p1)

  render: ->
    $("<div class='chat-message #{@poster}'>#{@parseText(@text)}</div>")

class UserAction
  constructor: (data, @chat) ->
    @poster = POSTER_CONSTANTS.user
    @action = data.action
    @payload = data.payload

  trigger: ->
    ActionDispatcher.dispatch(@action, @payload) if @action
    @chat.finishAction()
    @chat.postMessage(@message, @poster)

  render: ->

  componentDidMount: ->

class UserActionButton extends UserAction
  constructor: (data, @chat) ->
    super(data, @chat)
    @text = data.text
    @message = {type: "message", text: @text, route: data.route}
    @payload = if data.payload then data.payload else @text

  render: ->
    $button = $("<div class='chat-message user'>#{@text}</div>")
    $button.click => @trigger()
    return $button

class UserTextInput extends UserAction
  constructor: (data, @chat) ->
    super(data, @chat)
    @placeholder = data.placeholder
    @message = {type: "message", route: data.route}

  render: ->
    $form = $("<form class='text-input-form' />")
    @input = $input = $("<input type='text' placeholder='#{@placeholder}' />")
    $submit = $("<input type='button' value='submit' />")
    $form.append($input).append($submit)
    $form.submit (e) => @trigger(e)
    $submit.click (e) => @trigger(e)
    return $form

  componentDidMount: ->
    @input.focus()

  trigger: (e) ->
    e.preventDefault()
    val = @input.val()
    @message.text = val
    ActionDispatcher.dispatch(@action, val) if @action
    @chat.finishAction()
    @chat.postMessage(@message, @poster)

class TextButtons
  constructor: (data, @chat) ->
    @buttons = data.buttons

  render: ->
    $buttons_container = $("<div class='buttons-container'>")
    for button in @buttons
      button = new UserActionButton(button, @chat)
      $buttons_container.append(button.render())
    return $buttons_container

ActionDispatcher = {
  dispatch: (action, payload) ->
    @actions[action](payload)
  ajaxCall: (url, data, type='GET', success=->) ->
    $.ajax({url: url, data: data, type: type, success: success})
  actions: {
    "UPDATE_NAME": (payload) => ActionDispatcher.ajaxCall('users/2/update', {user: {name: payload}}, 'PATCH', -> console.log('success')),
    "UPDATE_SEARCH_AREA": (payload) => console.log 'fuc'
  }
}

message_types = {
  "message": Message
}

action_types = {
  "text_buttons": TextButtons,
  "text_button": UserActionButton,
  "text_input": UserTextInput
}

conversation_modules = gon.conversation_modules

POSTER_CONSTANTS = {
  user: "user",
  bot: "bot"
}

getInteraction = (route) ->
  [module, interaction] = route.split("/")
  conversation_modules[module][interaction]

createMessageObject = (message, chat, poster) ->
  MessageObject = message_types[message.type]
  new MessageObject(message, chat, poster)

createActionsObject = (actions, chat) ->
  ActionsObject = action_types[actions.type]
  new ActionsObject(actions, chat)

window.Chat = Chat
window.ChatBot = ChatBot





