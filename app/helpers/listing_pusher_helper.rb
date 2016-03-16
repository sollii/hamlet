module ListingPusherHelper
  def send_new_listings(from_time)
    new_listings = Listings.where{updated_at > from_time}
    users.each do|user|
      filtered_listings = Listings.where{updated_at > from_time}
      user.filters.each do |filter|
        filtered_listings = filter(filtered_listings)
      end
      push(filtered_listings, user)
    end
  end

  def push(listings, user)

  end
end
