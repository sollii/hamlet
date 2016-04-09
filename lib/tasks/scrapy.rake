namespace :scrapy do
  desc "Import Scraped Tasks"
  task :import => :environment do
    include ScraperHelper
    include ListingImportHelper
    finished_jobs = get_unconsumed_jobs()["jobs"]
    finished_jobs.each do |job|
      id = job["id"]
      listings = get_items(id)
      listings.each { |listing| import_listing(listing) }
      consume_job(id)
    end
  end

  desc "Scrape Area"
  task :scrape, [:area] => [:environment] do |t, args|
    include ScraperHelper
    puts scrape_area(args[:area])
  end
end
