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

class TextButtons extends UserAction
  constructor: (data, @chat) ->
    @buttons = data.buttons

  render: ->
    $buttons_container = $("<div class='buttons-container'>")
    for button in @buttons
      button = new UserActionButton(button, @chat)
      $buttons_container.append(button.render())
    return $buttons_container

action_types = {
  "text_buttons": TextButtons,
  "text_button": UserActionButton,
  "text_input": UserTextInput
}

window.createActionsObject = (actions, chat) ->
  ActionsObject = action_types[actions.type]
  new ActionsObject(actions, chat)

