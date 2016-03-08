include Math

class SchoolFilter < Filter
  def filter(listings)
    rating = self.rating
    desired_school_names = self.desired_schools.split("-")
    desired_schools = School.where{desired_school_names.include? name}.where{gs_rating >= rating}

    school_lat_lon_limits = []
    desired_schools.each do |school|
      school_lat_lon_limits = get_school_lat_lon_limit(school)
    end

    return listings.where{is_listing_in_school_range(address, desired_schools, school_lat_lon_limits)}
  end

  private

  def get_school_lat_lon_limit(school)
    lat = school.address.lat
    lon = school.address.lon

    earth_r = 6378137

    dn = 800
    de = 800

    dLat = dn/earth_r
    dLon = de/(earth_r*Math.cos(Math::PI*lat/180))

    latO = lat + dLat * 180/Pi
    lonO = lon + dLon * 180/Pi

    [(lat0-lat).abs, (lon0-lon).abs]
  end

  def is_listing_in_school_range(address, desired_schools, school_lat_lon_limits)
    desired_schools.each do |school|

    end
  end

end
