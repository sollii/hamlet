module ListingImportHelper
  def import_listing(listing)
    begin
      address = Address.create parse_address(listing["address"])
      listing_data = parse_listing(listing).merge({ address: address })
      Listing.create listing_data
      puts "created listing at #{address}!"
    rescue
      puts "error #{listing}"
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
