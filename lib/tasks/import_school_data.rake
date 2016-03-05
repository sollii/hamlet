namespace :import_school_data do
  desc "Calls the greatschool api and adds school data for schools in Berkeley CA"
  task great_schools: :environment do
    include GreatSchoolsApiHelper

    district_data = call_great_schools_api("#{@@BASE_URI}districts/#{state}/#{city}?#{@@GREATSCHOOLS_API_KEY}")
    city_school_data = call_great_schools_api("#{@@BASE_URI}schools/nearby?key=#{@@GREATSCHOOLS_API_KEY}&city=#{city}&state=#{state}&schoolType=public-private-charter&radius=50&limit=300")
    city_school_data['schools']['school'].each do |school|
      profile = call_great_schools_api("#{@@BASE_URI}schools/#{state}/#{school['gsId']}")['school']
      school_data = {
        name: school['name'],
        type: school['type'],
        gsRating: school['gsRating'],
        parentRating: school['parentRating'],
        gradeRange: school['gradeRange'],
        enrollment: school['enrollment'],
        address: school['address'],
        website: school['website'],
        lat: school['lat'],
        lon: school['lon']
      }

    end
  end

end
