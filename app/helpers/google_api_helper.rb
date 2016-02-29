module GoogleApiHelper
    @@GOOGLE_API_KEY = 'AIzaSyAi-E59X3_vswQ9fwc5xhxoZhPTYe_kARs'
    @@BASE_URI = 'https://maps.googleapis.com/maps/api'

    def build_url(api, format, params)
        "#{@@BASE_URI}/#{api}/#{format}?#{params}&key=#{@@GOOGLE_API_KEY}"
    end

    def call_api(api, format, params)
        params = URI.encode params
        url = build_url(api, format, params)
        return JSON.parse(RestClient.get(url))
    end

    def get_lat_long(address)
        response = call_api('geocode', 'json', "address=#{address}")
        if response["results"] and response["results"][0]
            return response["results"][0]["geometry"]["location"]
        end
    end
end
