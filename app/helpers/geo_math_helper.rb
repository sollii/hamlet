module GeoMathHelper
    @@MQ_API_KEY = 'PU4VcE4iuXOU2dUCPmUVHzqmdZzsEhYI'
    @@GOOGL_API_KEY = 'AIzaSyAi-E59X3_vswQ9fwc5xhxoZhPTYe_kARs'
    @@BASE_MATRIX_URI = "https://maps.googleapis.com/maps/api/distancematrix/json?origins="
    @@mapquest = MapQuest.new @@MQ_API_KEY

    def get_MQ_latLon(address)
        data = mapquest.geocoding.address address
        data.locations.each { |location| puts location[:latLng][:lat], location[:latLng][:lng] }
    end

    def get_matrix_times(source, destinations)
        call = build_matrix_call(source, destinations)
        encoded = URI.encode call

        return
    end

    private def build_matrix_call(source, destinations)
        call = @@BASE_MATRIX_URI
        source.gsub(/\s+/, '+')
        call += source + "&destinations="
        destinations.each do |address|
            address.gsub(/\s+/, '+')
            call += address + '|'
        end
        call += "&mode=driving&key=#{@@GOOGL_API_KEY}"
    end

    private def test_matrix_times
        count = 0
        source = "2133 Haste St. Berkeley"
        destinations = []
        (0..10).each do |testnum|
            Listing.all.each do |listing|
                break if count == 5
                count += 1
                addr = "#{listing.address.to_s}"
                destinations.append(addr)
            end
            puts get_matrix_times(source, destinations)
            count = 0
            destinations = []
            puts "\n Test #{testnum} with #{destinations.to_s()}\n"
        end
        puts "Test complete."
    end
end
