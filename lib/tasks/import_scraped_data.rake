namespace :import_scraped_data do
  desc "TODO"
  task listings: :environment do
    require 'smarter_csv'
    path = Rails.root.join('tmp', 'scraped_data', 'realtor_berkeley.csv')
    listings = SmarterCSV.process(path)
    throw listings[0]
  end

end
