class FilterStore
  constructor: () ->
    @base_url = '/filter'

  serverCall: (action, data, type="GET") ->
    $.ajax
      url: "#{@base_url}/#{action}"
      data: {filter: data}
      type: type

  setFilter: (filter_type, params) ->
    @serverCall('set', {type: filter_type, params: params}, 'POST')


window.FilterStore = FilterStore
