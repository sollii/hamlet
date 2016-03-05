namespace :import_scraped_data do
  desc "Import listings from excel to database"
  task listings: :environment do

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

  desc "Gets the lat and long of addresses from GoogleAPI then add it to the model"
  task add_lat_and_long_data: :environment do
    include GoogleApiHelper

    Address.where(lng: nil).each do |address|
      location = get_lat_long(address.to_s)
      address.lat = location["lat"]
      address.lng = location["lng"]
      address.save
      puts "lat lng found for #{address}"
    end
  end

end
