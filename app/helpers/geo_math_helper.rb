module GeoMathHelper
    require 'open-uri'
    @MQ_API_KEY = 'PU4VcE4iuXOU2dUCPmUVHzqmdZzsEhYI'
    @GOOGL_API_KEY = 'AIzaSyAi-E59X3_vswQ9fwc5xhxoZhPTYe_kARs'
    @mapquest = MapQuest.new @MQ_API_KEY

    def getMQLatLon(address)
        data = mapquest.geocoding.address address
        data.locations.each { |location| puts location[:latLng][:lat], location[:latLng][:lng] }
    end

    def getMatrixTimes(source, destinations)
        call = buildGoogMatrixCall(source, destinations)
        encoded = URI.encode call
        return RestClient.get encoded
    end

    def buildGoogMatrixCall(source, destinations)
        call = "https://maps.googleapis.com/maps/api/distancematrix/json?origins="
        source.gsub(/\s+/, '+')
        call += source + "&destinations="
        destinations.each do |address|
            address.gsub(/\s+/, '+')
            call += address + '|'
        end
        call += "&mode=driving&key=#{@GOOGL_API_KEY}"
    end
    traveltime = open("https://maps.googleapis.com/maps/api/distancematrix/json?origins=Vancouver+BC|Seattle&destinations=San+Francisco|Victoria+BC&mode=bicycling&language=fr-FR&key=#{@GOOGL_API_KEY}")
end
