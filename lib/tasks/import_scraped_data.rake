namespace :import_scraped_data do
  desc "TODO"
  task listings: :environment do

    filename = 'tmp/scraped_data/realtor_berkeley.csv'
    csv = File.read(filename).gsub(/\\"/,'""')
    csv = CSV.parse(csv)
    options = {:chunk_size => 100}
    listings = SmarterCSV.process(csv, options) do |chunk|
      chunk.each do |org|
        throw org
        org_data = {
          name: org[:name],
          link: DataEntryHelper.parse_org_link(org[:crunchbase_url]),
          homepage_url: org[:homepage_url],
          role: org[:primary_role],
          UUID: org[:crunchbase_uuid],
          domain: org[:homepage_domain],
          city: org[:location_city],
          region: org[:location_region],
          country: org[:location_country_code],
          description: org[:short_description]
        }
        Organization.create org_data
        puts "created #{org[:name]}!"
      end
    end
  end

end
