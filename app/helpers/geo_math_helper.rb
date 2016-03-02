module GeoMathHelper
  @@GOOGL_API_KEY = 'AIzaSyAi-E59X3_vswQ9fwc5xhxoZhPTYe_kARs'
  @@BASE_MATRIX_URI = "https://maps.googleapis.com/maps/api/distancematrix/json?origins="

  def get_matrix_dist(source, destinations)
    call = build_matrix_call(source, destinations)
    encoded = URI.encode call
    return JSON.parse(RestClient.get(encoded))
  end

  #Source: String
  #Destinations: Listing Array
  #Max_Dist: Integer
  #Max_Time: Integer
  def filter_matrix(source, destinations, max_dist, max_time)
    matrix_result = get_matrix_dist(source, destinations)
    if (matrix_result["status"] == "OK")
      filtered_listings = []
      puts matrix_result["rows"][0]["elements"]
      matrix_result["rows"][0]["elements"].each_with_index do |result, index|
        if (result["distance"]["value"] <= max_dist and result["duration"]["value"] <= max_time)
          filtered_listings.append(destinations[index])
        end
      end
    end
    return filtered_destinations
  end

  private def build_matrix_call(source, destinations)
    call = @@BASE_MATRIX_URI
    call += "#{source}&destinations="
    destinations.each do |destination|
      call += "#{destination.address.latitude} #{destination.address.longitude}|"
    end
    call += "&mode=driving&key=#{@@GOOGL_API_KEY}"
  end

  private def test_matrix_dist
    count = 0
    source = Listing.last.address
    destinations = []
    (0..10).each do |testnum|
      Listing.all.each do |listing|
        break if count == 5
        count += 1
        destinations.append(listing.address)
      end
      puts get_matrix_dist(source, destinations)
      puts "\n Test #{testnum} completed with #{destinations.to_s()}\n"
      count = 0
      destinations = []
    end
    puts "Test complete."
  end
end
