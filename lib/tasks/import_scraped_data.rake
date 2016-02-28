namespace :import_scraped_data do
  desc "TODO"
  task listings: :environment do

    filename = 'tmp/scraped_data/realtor_berkeley.csv'
    options = {:chunk_size => 100}
    listings = SmarterCSV.process(filename, options) do |chunk|
      chunk.each do |listing|
        listing_data = {

        }

        Organization.create org_data
        puts "created #{org[:name]}!"
      end
    end
  end

end
