require "./version"
require "./config"

# TODO: Write documentation for `Geocoder`
module Geocoder
  CONFIG = Config.new

  def self.config(&)
    yield CONFIG
  end

  # Pass the given geocoding query to the default geocoding backend.
  #
  # ```
  # Geocoder.search "1060 W Addison, Chicago, IL"
  # # => [Geocoder::Result(@latitude=41.94818455, @longitude=-87.65555899980043)]
  # ```
  def self.search(query : String)
    CONFIG.backend.search query
  end
end
