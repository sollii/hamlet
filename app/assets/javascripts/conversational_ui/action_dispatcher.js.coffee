dispatch = (action, payload) ->
  actions[action](payload)

ajaxCall = (url, data, type='GET', success=->) ->
  $.ajax({url: url, data: data, type: type, success: success})

UPDATE_NAME = (payload) =>
  ActionDispatcher.ajaxCall('users/2/update', {user: {name: payload}}, 'PATCH', -> console.log('success'))

UPDATE_SEARCH_AREA = (payload) =>
  console.log 'fuc'

actions = {
  "UPDATE_NAME": UPDATE_NAME,
  "UPDATE_SEARCH_AREA": UPDATE_SEARCH_AREA
}


window.ActionDispatcher = {
  dispatch: dispatch
}
