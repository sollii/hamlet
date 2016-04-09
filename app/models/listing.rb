class Listing < Place

  def self.create_with_address(listing_params, address_params)
    listing = Listing.create listing_params
    listing.add_address address_params
    return listing
  end

  def changed?(new_params)
    self.price != new_params[:price]
  end

  def update_watched_attributes(params)
    self.update price: params[:price]
  end

  def self.get_listing_from_address(address_params)
    Address.where(address_params).each do |address|
      place = address.place.first
      if place and place.place_type == "Listing"
        return place
      end
    end
    return nil
  end

  def to_s()
    "#{self.bedrooms.to_s}#{self.bathrooms}#{self.sq_footage}#{self.year}#{self.price}" + self.address.to_s
  end

  def self.update_or_create(listing_params, address_params)
    if Address.unique?(address_params)
      return self.create_with_address(listing_params, address_params)
    else
      listing = Listing.get_listing_from_address(address_params)
      if not listing
        return self.create_with_address(listing_params, address_params)
      else
        if listing.changed?(listing_params)
          listing.update_watched_attributes(listing_params)
          return listing
        else
          return nil
        end
      end
    end
  end

end
