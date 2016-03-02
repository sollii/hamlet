$ ->
  $.getScript
    url: "https://maps.googleapis.com/maps/api/js?key=AIzaSyBr13Xn_lJ4EMP1AciHBHrQ2DWR5S3TppI",
    success: initGMaps

initGMaps = ->
  map = new GoogleMaps("#listings-map", {lat: 37.871470, lng: -122.273584})
  map.addListingMarkers(gon.homes)

  $("#clear-markers").click ->
    map.clearAllListings()

  $("#rerender-markers").click ->
    map.addListingMarkers(gon.homes)

