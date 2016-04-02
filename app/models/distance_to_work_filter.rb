class DistanceToWorkFilter < Filter
  many_to_one :address
  @@OSRM_URL = "http://router.project-osrm.org/table?"
  def filter(listings)
    max_distance = self.distance_to_work
    work_address = self.address

    request_url = @@OSRM_URL + "&src=#{work_address.lat},#{work_address.lon}"
    listings.each do |listing|
      request_url += "&dst=#{listing.address.lat},#{listing.address.lon}"
    end

    distances_result = JSON.parse(RestClient.get(request_url))["distance_table"][0]
    filtered_address_ids = []
    l = listings.all
    distances_result.each_with_index do |distance, index|
      if distance.to_i < max_distance
        filtered_address_ids.append(l[index].address.id)
      end
    end

    return listings.where(address_id: filtered_address_ids)
  end
end
