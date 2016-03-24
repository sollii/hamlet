class SchoolFilter < Filter
  def filter(listings)
    desired_schools = School
    if self.rating != nil
      rating = self.rating
      desired_schools = desired_schools.where{gs_rating >= rating}
    end
    if self.desired_schools != nil and !self.desired_schools.blank?
      desired_schools = desired_schools.where(name: self.desired_schools.split("-"))
    end
    lat_lon_limits = []
    desired_schools.each do |school|
      lat_lon_limits.append(get_school_lat_lon_limit(school))
    end
    address_id_list = []
    listings.each do |listing|
      address_id_list.append(listing.address_id)
    end
    addresses = Address.where(id: address_id_list)
    addr_id = []
    desired_schools.each_with_index do |school, index|
      addr_id += addresses.where{lat < school.address.lat+lat_lon_limits[index]}.where{lat > school.address.lat-lat_lon_limits[index]}.where{lon < school.address.lon+lat_lon_limits[index]}.where{lon > school.address.lon-lat_lon_limits[index]}.all
    end
    addr_id = addr_id.collect{|address| address.id}
    return listings.where(address_id: addr_id)
  end

  private

  def get_school_lat_lon_limit(school)
    lat = school.address.lat
    lon = school.address.lon
    earth_r = 6378137
    dn = 2000
    de = 2000
    dLat = dn/earth_r
    dLon = de/(earth_r*Math.cos(Math::PI*lat/180))
    latO = lat + dLat * 180/Math::PI
    lonO = lon + dLon * 180/Math::PI
    (lonO-lon).abs
  end
end
