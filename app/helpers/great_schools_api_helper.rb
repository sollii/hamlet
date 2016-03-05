module GreatSchoolsApiHelper
  @@GREATSCHOOLS_API_KEY = "j43gxioytxaxuwk1c6h1xwxx"
  @@BASE_URI = "http://api.greatschools.org/"

  def call_great_schools_api(request)
    return JSON.parse(Hash.from_xml(RestClient.get(request)).to_json)
  end

end
