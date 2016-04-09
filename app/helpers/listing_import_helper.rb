module ListingImportHelper
  def import_listing(listing)
    begin
      listing_data = parse_listing(listing)
      address_data = parse_address(listing["address"])
      listing = Listing.update_or_create(listing_data, address_data)
      if listing
        puts "created listing at #{listing.address}!"
      else
        puts "nothing to update"
      end
    rescue
      puts "error"
    end
  end

  def parse_address(address)
    parts = address.split(",")
    street = parts[0]
    city = parts[1].strip()
    parts = parts[2].strip().split(" ")
    state = parts[0]
    zipcode = parts[1]
    return {street: street, city: city, state: state, zip: zipcode}
  end

  def parse_listing(listing)
    return {
      bedrooms: listing["beds"].to_i,
      bathrooms: listing["baths"].to_i,
      sq_footage: listing["sqft"].gsub!(/,/,'').to_i,
      price: listing["price"].gsub!(/[,$]/,'').to_i,
    }
  end
end
