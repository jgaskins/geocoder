require "json"
require "uri"
require "./address"

module Geocoder
  struct Result
    include JSON::Serializable

    getter latitude : Float64
    getter longitude : Float64
    getter address : Address?

    def initialize(*, @latitude, @longitude, @address = Address.new)
    end

    def format : String
      String.build { |str| format str }
    end

    def format(io : IO) : Nil
      io << latitude << ',' << longitude
    end

    def apple_maps_url : URI
      URI.parse "https://maps.apple.com/?ll=#{format}"
    end

    def google_maps_url : URI
      URI.parse "https://www.google.com/maps/place/@#{format},17z/"
    end
  end
end
