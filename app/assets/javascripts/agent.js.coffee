# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  modules = new ConversationModules(gon.conversation_modules)
  chat = new Chat("#message-box-messages", "#user-actions")
  agent = new ChatBot(chat, modules)
  chat.addChatBot(agent)
  agent.perform("onboarding/greeting")

