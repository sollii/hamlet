namespace :import_school_data do
  desc "Calls the greatschool api and adds school data for schools in Berkeley CA"
  task great_schools_berkeley: :environment do
    include GreatSchoolsApiHelper

    city_school_data = call_great_schools_api("#{@@BASE_URI}schools/nearby?key=#{@@GREATSCHOOLS_API_KEY}&city=Berkeley&state=CA&schoolType=public-private-charter&radius=20&limit=5000")
    city_school_data['schools']['school'].each do |school|
      school_data = {
        name: school['name'],
        school_type: school['type'],
        gs_rating: school['gsRating'],
        parent_rating: school['parentRating'],
        grade_range: school['gradeRange'],
        enrollment: school['enrollment'],
        website: school['website'],
      }
      address_data = {
        street: school['address'].split(",").first,
        city: school['city'],
        state: school['state'],
        zip: school['address'][-5..-1],
        lat: school['lat'],
        lon: school['lon']
      }
      address = Address.create address_data
      school_data = school_data.merge({:address => address})
      School.create school_data
      puts "created school at #{address}!"
    end
  end

end
