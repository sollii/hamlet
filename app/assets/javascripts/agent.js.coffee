# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  chat = new Chat("#message-box", "#user-actions")
  agent = new ChatBot(chat)
  chat.addChatBot(agent)
  agent.perform("onboarding/greeting")

