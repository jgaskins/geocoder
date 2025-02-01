require "json"
require "uri"

module Geocoder
  struct Result
    include JSON::Serializable

    getter latitude : Float64
    getter longitude : Float64

    def initialize(*, @latitude, @longitude)
    end

    def to_s(io)  : Nil
      io << latitude << ',' << longitude
    end

    def apple_maps_url : URI
      URI.parse "https://maps.apple.com/?ll=#{to_s}"
    end

    def google_maps_url : URI
      URI.parse "https://www.google.com/maps/place/@#{to_s},17z/"
    end
  end
end
