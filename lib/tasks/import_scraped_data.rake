namespace :import_scraped_data do
  desc "Import listings from excel to database"
  task listings: :environment do

    filename = 'tmp/scraped_data/realtor_berkeley.csv'
    options = {:chunk_size => 100}
    listings = SmarterCSV.process(filename, options) do |chunk|
      chunk.each do |listing|
        address_data = {
          street: listing[:street],
          city: listing[:city],
          state: listing[:state],
          zip: listing[:zip]
        }
        address = Address.create address_data
        Listing.create address: address
        puts "created listing at #{address}!"
      end
    end
  end

  desc "Gets the lat and long of addresses from GoogleAPI then add it to the model"
  task add_lat_and_lon_data: :environment do
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
