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

window.Chat = Chat
