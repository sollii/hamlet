module GreatSchoolsApiHelper
  @@GREATSCHOOLS_API_KEY = "j43gxioytxaxuwk1c6h1xwxx"
  @@BASE_URI = "http://api.greatschools.org/"

  #Scrapes GreatSchools.com for schools in City, State
  def scrape_great_schools(state, city)
    district_data = call_great_schools_api("#{@@BASE_URI}districts/#{state}/#{city}?#{@@GREATSCHOOLS_API_KEY}")
    city_school_data = call_great_schools_api("#{@@BASE_URI}schools/nearby?key=#{@@GREATSCHOOLS_API_KEY}&city=#{city}&state=#{state}&schoolType=public-private-charter&radius=50&limit=300")

    city_school_data['schools']['school'].each do |school|
      profile = call_great_schools_api("#{@@BASE_URI}schools/#{state}/#{school['gsId']}")['school']

    end
  end

  private

  def call_great_schools_api(request)
    return JSON.parse(Hash.from_xml(RestClient.get(request)).to_json)
  end

end
