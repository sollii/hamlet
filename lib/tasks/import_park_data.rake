namespace :import_park_data do
  desc "TODO"
  task berkeley: :environment do
    include GoogleApiHelper

    filename = 'tmp/scraped_data/Parks.csv'
    options = {:chunk_size => 100}

    listings = SmarterCSV.process(filename, options) do |chunk|
      chunk.each do |park|
        begin
          location = get_lat_long("#{park[:address]}, Berkeley, CA")
          park_data = {
             name: park[:name],
             address: park[:address],
             park_area: park[:shape_area],
             lat: location["lat"],
             lon: location["lng"]
          }
          Park.create park_data
          puts "created model for #{park[:name]}!"
        rescue
          puts "error"
        end
      end
    end
  end
end
