onboarding = {
  greeting: {
    bot_messages: [
      {type: "message", text: "Hi! Welcome to Hamlet!"},
      {type: "message", text: "Let's get you onboarded"}
    ],
    user_actions: {
      type: "text_buttons",
      buttons: [
        {text: "Hi!", route: "onboarding/get_name"}
      ]
    }
  },
  get_name: {
    bot_messages: [
      {type: "message", text: "What's your name?"}
    ],
    user_actions: {
      type: "text_buttons",
      buttons: [
        {text: "Zhi", route: "onboarding/end", action: "UPDATE_NAME"}
      ]
    }
  },
  end: {
    bot_messages: [
      {type: "message", text: "Good bye, #{1 + 1}"}
    ]
  }
}
