module GoogleApiHelper
    @@GOOGLE_API_KEY = 'AIzaSyAi-E59X3_vswQ9fwc5xhxoZhPTYe_kARs'
    @@base_uri = 'https://maps.googleapis.com/maps/api'

    def build_url(api, format, params)
        "#{@@base_uri}/#{api}/#{format}?#{params}&key=#{@@GOOGLE_API_KEY}"
    end

    def call_api(api, format, params)
        params = URI.encode params
        url = build_url(api, format, params)
        print url
        return JSON.parse(RestClient.get(url))
    end

    def get_lat_long(address)
        call_api('geocode', 'json', "address=#{address}")
    end

    def t
        get_lat_long "1600 Amphitheatre Parkway, Mountain View, CA"
    end
end
