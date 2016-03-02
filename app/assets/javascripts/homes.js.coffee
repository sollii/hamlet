$ ->
  $.getScript
    url: "https://maps.googleapis.com/maps/api/js?key=AIzaSyBr13Xn_lJ4EMP1AciHBHrQ2DWR5S3TppI",
    success: initMap

  map = null

initMap = ->
  console.log('hi')
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 8
  })
