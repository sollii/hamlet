class ConversationModules
  constructor: (@modules) ->

  getInteraction: (route) ->
    [module, interaction] = route.split("/")
    @modules[module][interaction]

window.ConversationModules = ConversationModules
