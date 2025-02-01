require "./error"
require "./result"

module Geocoder
  # The `Backend` is the base class for all Geocoder backends.
  abstract class Backend
    abstract def search(query : String) : Array(Result)

    class Error < Geocoder::Error
    end
  end
end
