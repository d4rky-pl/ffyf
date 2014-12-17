class FoursquareFetcher
  def self.nearby_locations(lat, long)
    require 'net/http'
    uri = URI.parse('https://api.foursquare.com/v2/venues/search')
    args = {
        ll:  "#{lat},#{long}",
        client_id: "",
        client_secret: "",
        limit: 10, # so it won't take too long
        radius: 10000,
        sortByDistance: 1,
        query: 'kebab,pizza,burger,fastfood',
        v: Time.now.strftime("%Y%m%d")
    }
    uri.query = URI.encode_www_form(args)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    parsed = JSON.parse(response.body)

    venues = parsed['response']['venues']
    venues
  end
end
