# $ ->
#   $.getScript
#     url: "https://maps.googleapis.com/maps/api/js?key=AIzaSyBr13Xn_lJ4EMP1AciHBHrQ2DWR5S3TppI",
#     success: initGMaps

#   console.log gon

#   $.ajax
#     type: "GET"
#     url: "/filter"
#     success:(data) ->
#       console.log data
#     error:(data) ->
#       console.log data.responseText
#     data:
#       filter:
#         source: "3110 California St, Berkeley, CA 94703, USA"
#         max_dist: 10000
#         max_time: 600
#     dataType: "json"

initGMaps = ->
  map = new GoogleMaps("#listings-map", {lat: 37.871470, lon: -122.273584})
  map.addListingMarkers(gon.homes)

  $("#clear-markers").click ->
    map.clearAllListings()

  $("#rerender-markers").click ->
    map.addListingMarkers(gon.homes)


