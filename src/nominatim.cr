require "http"
require "uri"
require "json"
require "./backend"
require "./log"

module Geocoder
  class Nominatim < Backend
    def search(query : String) : Array(Result)
      search!(query).map do |result|
        address = {result.address.house_number, result.address.road}
        if address[0] || address[1]
          address = address.join(' ').strip
        else
          address = nil
        end
        Result.new(
          latitude: result.lat.to_f,
          longitude: result.lon.to_f,
          address: Address.new(
            street1: address,
            neighborhood: result.address.neighbourhood,
            municipality: result.address.municipality,
            suburb: result.address.suburb,
            city: result.address.city,
            county: result.address.county,
            state: result.address.state,
            zip: result.address.postcode,
            country: result.address.country,
          ),
        )
      end
    end

    def search!(query : String)
      params = URI::Params{
        "q" => query,
        # "format"          => "json",
        "format" => "jsonv2",
        # "format"          => "geojson",
        # "format"          => "geocodejson",
        "addressdetails"  => "1",
        "accept-language" => "en-us",
      }
      start = Time.monotonic
      response = HTTP::Client.get("https://nominatim.openstreetmap.org/search?#{params}")
      finish = Time.monotonic
      Log.debug &.emit "Request",
        query: query,
        duration_ms: (finish - start).total_milliseconds
      if response.success?
        Array(JSONv2Result).from_json response.body
      else
        raise Error.new(response.body)
      end
    end

    struct JSONv2Result
      include JSON::Serializable

      getter place_id : Int64
      getter licence : String
      getter osm_type : String # enum?
      getter osm_id : Int64
      getter lat : String
      getter lon : String
      getter category : String # enum?
      getter type : String     # enum?
      getter place_rank : Int64
      getter importance : Float64
      getter addresstype : String # enum?
      getter display_name : String
      getter address : Address

      struct Address
        include JSON::Serializable
        # include JSON::Serializable::Unmapped

        # I don't know if any of these are guaranteed

        getter house_number : String?
        getter road : String?
        getter city : String?
        getter state : String?
        getter postcode : String?
        getter country : String?
        getter country_code : String?
        getter leisure : String?
        getter neighbourhood : String?
        getter suburb : String?
        getter municipality : String?
        getter county : String?
      end

      getter boundingbox : Array(String)
    end
  end
end
