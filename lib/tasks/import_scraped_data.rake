namespace :import_scraped_data do
  desc "TODO"
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

end
