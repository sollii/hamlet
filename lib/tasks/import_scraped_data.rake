namespace :import_scraped_data do

  desc "Import listings and add lat lon"
  task add_all: :environment do
    Rake::Task["import_scraped_data:listings"].invoke
    Rake::Task["import_scraped_data:add_lat_and_lon_data"].invoke
  end

  desc "Import listings from excel to database"
  task listings_2: :environment do

    filename = 'tmp/scraped_data/realtor_berkeley.csv'
    options = {:chunk_size => 100}
    listings = SmarterCSV.process(filename, options) do |chunk|
      chunk.each do |listing|
        begin
          address_data = {
            street: listing[:street],
            city: listing[:city],
            state: listing[:state],
            zip: listing[:zip]
          }
          address = Address.create address_data
          listing_data = {
             bedrooms: listing[:bedrooms].to_i,
             bathrooms: listing[:bathrooms].to_i,
             sq_footage: listing[:sq_footage].gsub!(/,/,'').to_i,
             year: listing[:year][-4..-1].to_i,
             price: listing[:tax_valuation].gsub!(/[,$]/,'').to_i,
             address: address
          }
          Listing.create listing_data
          puts "created listing at #{address}!"
        rescue
          puts "error"
        end
      end
    end
  end

  desc "Import listings from json to database"
  task listings: :environment do
    filename = "#{Rails.root}/tmp/scraped_data/items.json"
    file = File.read(filename)
    listings = JSON.parse(file)

    def parse_address(address)
      parts = address.split(",")
      street = parts[0]
      city = parts[1].strip()
      parts = parts[2].strip().split(" ")
      state = parts[0]
      zipcode = parts[1]
      return {street: street, city: city, state: state, zip: zipcode}
    end

    listings.each do |listing|
      begin
        puts listing
        address_data = parse_address(listing["address"])
        address = Address.create address_data
        listing_data = {
           bedrooms: listing["beds"].to_i,
           bathrooms: listing["baths"].to_i,
           sq_footage: listing["sqft"].gsub!(/,/,'').to_i,
           price: listing["price"].gsub!(/[,$]/,'').to_i,
           address: address
        }
        Listing.create listing_data
        puts "created listing at #{address}!"
      rescue
        puts "error"
      end
    end
  end

  desc "Gets the lat and long of addresses from GoogleAPI then add it to the model"
  task add_lat_and_lon_data: :environment do
    include GoogleApiHelper

    Address.where(lon: nil).each do |address|
      location = get_lat_long(address.to_s)
      address.lat = location["lat"]
      address.lon = location["lng"]
      address.save
      puts "lat lon found for #{address}"
    end
  end

end
