$ ->
  $.getScript
    url: "https://maps.googleapis.com/maps/api/js?key=AIzaSyBr13Xn_lJ4EMP1AciHBHrQ2DWR5S3TppI",
    success: initGMaps

  console.log gon


initGMaps = ->
  map = initMap()
  initMarkers(gon.homes, map)

initMap = ->
  new google.maps.Map(document.getElementById('listings-map'), {
    center: {lat: 37.871470, lng: -122.273584},
    zoom: 12
  })

initMarkers = (listings, map) ->
  for listing in listings
    addListingToMap(listing, map)

createListing = (listing, map) ->
  marker = new google.maps.Marker({
    position: listing.latlong,
    map: map,
    title: 'Hello World!'
  })

addListingEventListeners = (marker) ->
  marker.addListener 'click', -> console.log 'hi'

addListingToMap = (listing, map) ->
  addListingEventListeners(createListing(listing, map))









