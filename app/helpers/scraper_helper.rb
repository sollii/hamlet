module ScraperHelper
  @@API_KEY = '89c93bebfd4a4aaa9f0eb12c24308088'
  @@PROJECT_ID = '51496'
  @@URI = 'scrapinghub.com'
  @@CONSUMED_TAG = "consumed"
  @@TEST_TAG = "test"

  def build_url(subdomain, method)
    "https://#{subdomain}.#{@@URI}#{method}"
  end

  def scrape_area(area)
    url = build_url("dash", "/api/run.json")
    params = {apikey: @@API_KEY, area: area, project: @@PROJECT_ID, spider: 'zillow'}
    RestClient.post(url, params)
  end

  def get_unconsumed_jobs()
    url = build_url("dash", "/api/jobs/list.json")
    params = {apikey: @@API_KEY, state: "finished", lacks_tag: @@CONSUMED_TAG, project: @@PROJECT_ID}
    JSON.parse(RestClient.get(url, {accept: :json, params: params}))
  end

  def get_test_jobs()
    url = build_url("dash", "/api/jobs/list.json")
    params = {apikey: @@API_KEY, state: "finished", has_tag: @@TEST_TAG, project: @@PROJECT_ID}
    JSON.parse(RestClient.get(url, {accept: :json, params: params}))
  end

  def consume_job(id)
    url = build_url("dash", "/api/jobs/update.json")
    params = {apikey: @@API_KEY, project: @@PROJECT_ID, job: id, add_tag: @@CONSUMED_TAG}
    RestClient.post(url, params)
  end

  def get_items(id)
    url = build_url("storage", "/items/#{id}")
    params = {apikey: @@API_KEY}
    JSON.parse(RestClient.get(url, {accept: :json, params: params}))
  end
end
