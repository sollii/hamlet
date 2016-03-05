module GoogleApiHelper
  @@GOOGLE_API_KEY = 'AIzaSyAi-E59X3_vswQ9fwc5xhxoZhPTYe_kARs'
  @@BASE_URI = 'https://maps.googleapis.com/maps/api'

  def build_url(api, format)
    "#{@@BASE_URI}/#{api}/#{format}"
  end

  def call_api(api, format, params)
    url = build_url(api, format)
    params = params.merge({key: @@GOOGLE_API_KEY})
    return JSON.parse(RestClient.get(url, params: params))
  end

  def get_lat_long(address)
    response = call_api('geocode', 'json', {address: address})
    if response["results"] and response["results"][0]
      return response["results"][0]["geometry"]["location"]
    end
  end

  def destinations_dist_from_source(source, destinations)
    destinations = destinations.join("|")
    call_api('distancematrix', 'json', {origins: source, destinations: destinations})
  end

  #Source: String
  #Destinations: Listing Array
  #Max_Dist: Integer
  #Max_Time: Integer
  def filter_listings_by_dist_from_source(source, listings, max_dist, max_time)
    listing_addresses = listings.collect {|listing| listing.address.to_s}
    response = destinations_dist_from_source(source, listing_addresses)
    if (response["status"] == "OK")
      puts response
      filtered_listings = []
      response["rows"][0]["elements"].each_with_index do |result, index|
        if (result["distance"]["value"] <= max_dist and result["duration"]["value"] <= max_time)
          filtered_listings.append(listings[index])
        end
      end
    end
    return filtered_listings
  end

end
