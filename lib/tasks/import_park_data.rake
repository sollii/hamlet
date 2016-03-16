namespace :import_park_data do
  desc "TODO"
  task berkeley: :environment do
    include GoogleApiHelper

    filename = 'tmp/scraped_data/Parks.csv'
    options = {:chunk_size => 100}

    listings = SmarterCSV.process(filename, options) do |chunk|
      chunk.each do |park|
        begin
          location = get_lat_long("#{park[:Address]}, Berkeley, CA")
          park_data = {
             name: park[:Name],
             address: park[:Address],
             park_area: park[:Shape_area],
             lat: location[:lat],
             lon: location[:lon]
          }
          Park.create park_data
          puts "created park at #{park[:address]}!"
        rescue
          puts "error"
        end
      end
    end
  end
end
