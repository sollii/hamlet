class CityParksFilter < Filter
  def filter(listings)
    desired_parks = Park
    if self.park_names != nil and !self.park_names.blank?
      desired_parks = desired_parks.where(name: self.park_names.split("-"))
    end
    lat_lon_limits = []
    desired_parks.each do |park|
      lat_lon_limits.append(get_park_lat_lon_limit(park, self.distance_to_park.to_i))
    end
    address_id_list = []
    listings.each do |listing|
      address_id_list.append(listing.address_id)
    end
    addresses = Address.where(id: address_id_list)
    addr_id = []
    desired_parks.each_with_index do |park, index|
      addr_id += addresses.where{lat < park.lat+lat_lon_limits[index]}.where{lat > park.lat-lat_lon_limits[index]}.where{lon < park.lon+lat_lon_limits[index]}.where{lon > park.lon-lat_lon_limits[index]}.all
    end
    puts addr_id, desired_parks,  'hi'
    addr_id = addr_id.collect{|address| address.id}
    return listings.where(address_id: addr_id)
  end

  private

  def get_park_lat_lon_limit(park, distance)
    lat = park.lat
    lon = park.lon
    earth_r = 6378137
    dn = distance /1.5
    de = distance /1.5
    dLat = dn/earth_r
    dLon = de/(earth_r*Math.cos(Math::PI*lat/180))
    latO = lat + dLat * 180/Math::PI
    lonO = lon + dLon * 180/Math::PI
    (lonO-lon).abs
  end
end
