module ScraperHelper
  @@API_KEY = '89c93bebfd4a4aaa9f0eb12c24308088'
  @@PROJECT_ID = '51496'
  @@URI = 'scrapinghub.com'

  def build_url(subdomain, method)
    "https://#{subdomain}.#{@@URI}#{method}?apikey=#{@@API_KEY}"
  end

  def scrape_area(area)
    url = build_url("dash", "/api/run.json")
    params = {area: area, project: @@PROJECT_ID, spider: 'zillow'}
    RestClient.post(url, params)
  end

  def get_items(id)
    url = build_url("storage", "/items#{id}")
    JSON.parse(RestClient.get(url, {:accept => :json}))
  end
end
