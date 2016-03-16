module ListingPusherHelper
  def send_new_listings(from_time)
    new_listings = Listing.where{updated_at > from_time}
    user = User.first
    push(user.filter_listings(new_listings), user)
    # User.each do|user|
    #   push(user.filter_listings(new_listings), user)
    # end
  end

  def push(listings, user)
    puts 'sdasd'
    return listings
  end
end
