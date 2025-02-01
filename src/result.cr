require "json"

module Geocoder
  struct Result
    include JSON::Serializable

    getter latitude : Float64
    getter longitude : Float64

    def initialize(*, @latitude, @longitude)
    end
  end
end
