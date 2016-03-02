collection :@homes
attributes :address
node(:latlong) { |home| {lat: home.address.latitude, lng: home.address.longitude }}
