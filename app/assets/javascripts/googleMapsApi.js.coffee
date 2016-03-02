class GoogleMaps
  constructor: (@container, @center) ->
    @initZoom = 12
    @map = @initMap()
    @listings = []

  initMap: ->
    new google.maps.Map($("#{@container}")[0], {
      center: @center,
      zoom: @initZoom
    })

  addListingMarkers: (listings) ->
    renderedListings = listings.map (listing) =>
      @addListingMarker(listing)

    @listings = @listings.concat(renderedListings)

  createListingMarker: (listing) ->
    new google.maps.Marker({
      position: listing.latlong,
      map: @map
    })

  addListingMarkerEventListeners: (listingMarker) ->
    listingMarker.addListener 'click', -> console.log 'hi'
    return listingMarker

  addListingMarker: (listing) ->
    @addListingMarkerEventListeners(@createListingMarker(listing))

  clearListing: (listing) ->
    listing.setMap(null)

  clearListings: (listings) ->
    listings.map (listing) => @clearListing(listing)

  clearAllListings: ->
    @clearListings(@listings)
    @listings = []

window.GoogleMaps = GoogleMaps
