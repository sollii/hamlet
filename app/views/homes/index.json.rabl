collection :@homes
attributes :address
node(:latlong) { |home| {lat: home.address.lat, lon: home.address.lon }}
