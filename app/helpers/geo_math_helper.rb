module GeoMathHelper
    @MQ_API_KEY = 'PU4VcE4iuXOU2dUCPmUVHzqmdZzsEhYI'
    @GOOGL_API_KEY = 'AIzaSyAi-E59X3_vswQ9fwc5xhxoZhPTYe_kARs'
    @mapquest = MapQuest.new @MQ_API_KEY

    def getMQLatLon(address)
        data = mapquest.geocoding.address address
        data.locations.each { |location| puts location[:latLng][:lat], location[:latLng][:lng] }
    end

    def getMatrixTimes(source, destinations)
        call = buildMatrixCall(source, destinations)
        encoded = URI.encode call
        return JSON.parse(RestClient.get(encoded))
    end

    private def buildMatrixCall(source, destinations)
        call = "https://maps.googleapis.com/maps/api/distancematrix/json?origins="
        source.gsub(/\s+/, '+')
        call += source + "&destinations="
        destinations.each do |address|
            address.gsub(/\s+/, '+')
            call += address + '|'
        end
        call += "&mode=driving&key=#{@GOOGL_API_KEY}"
    end

    private def testMatrixTimes
        count = 0
        source = "2133 Haste St. Berkeley"
        destinations = []
        (0..10).each do |testnum|
            Listing.all.each do |listing|
                break if count == 5
                count += 1
                addr = "#{listing.address.street} #{listing.address.city}"
                destinations.append(addr)
            end
            puts getMatrixTimes(source, destinations)
            count = 0
        end
        puts "Test complete."
    end
end
