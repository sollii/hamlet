class Message
  constructor: (data, @chat, @poster) ->
    @text = data.text
    @action = data.action
    @route = data.route

  parseText: (text) ->
    text.replace /#{(.*?)}/g, (match, p1) -> eval(p1)

  render: ->
    $("<div class='chat-message #{@poster}'>#{@parseText(@text)}</div>")

message_types = {
  "message": Message
}

window.createMessageObject = (message, chat, poster) ->
  MessageObject = message_types[message.type]
  new MessageObject(message, chat, poster)
