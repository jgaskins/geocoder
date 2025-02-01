require "http"
require "uri"
require "json"
require "./backend"
require "./log"

module Geocoder
  class Nominatim < Backend
    def search(query : String) : Array(Result)
      search!(query).map do |result|
        Result.new(
          latitude: result.lat.to_f,
          longitude: result.lon.to_f,
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

        # I don't know if any of these are guaranteed

        getter house_number : String?
        getter road : String?
        getter city : String?
        getter state : String?
        getter postcode : String?
        getter country : String?
        getter country_code : String?
      end

      getter boundingbox : Array(String)
    end
  end
end
