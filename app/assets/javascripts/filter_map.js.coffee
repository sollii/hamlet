class FilterMap extends GoogleMaps

  constructor: (@container, @center) ->
    super(@container, @center)
    @filters = []

  addFilter: (filter) ->
