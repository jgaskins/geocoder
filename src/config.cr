require "./backend"
require "./nominatim"

module Geocoder
  class Config
    property backend : Backend { Nominatim.new }
  end
end
