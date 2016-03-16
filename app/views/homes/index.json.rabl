collection :@homes
attributes :address
node(:latlong) { |home| {lat: home.address.lat, lng: home.address.lng }}
