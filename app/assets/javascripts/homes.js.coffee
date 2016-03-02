$ ->
  $.getScript
    url: "https://maps.googleapis.com/maps/api/js?key=AIzaSyBr13Xn_lJ4EMP1AciHBHrQ2DWR5S3TppI",
    success: initGMaps

  console.log gon

map = null

initGMaps = ->
  initMap()
  initMarkers(gon.homes)



initMap = ->
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 37.871470, lng: -122.273584},
    zoom: 12
  })

initMarkers = (listings) ->
  for listing in listings
    createMarkerAt(listing.latlong)

createMarkerAt = (latlong) ->
  console.log latlong
  new google.maps.Marker({
    position: latlong,
    map: map,
    title: 'Hello World!'
  });
