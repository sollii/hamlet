collection :@homes
attributes :address
node(:latlng) { |home| {lat: home.address.lat, lng: home.address.lon }}
