require "json"

struct Geocoder::Address
  include JSON::Serializable

  getter street1 : String?
  getter street2 : String?
  getter neighborhood : String?
  getter municipality : String?
  getter suburb : String?
  getter city : String?
  getter county : String?
  getter state : String?
  getter zip : String?
  getter country : String?

  def initialize(
    @street1 = nil,
    @street2 = nil,
    @neighborhood = nil,
    @municipality = nil,
    @suburb = nil,
    @city = nil,
    @county = nil,
    @state = nil,
    @zip = nil,
    @country = nil,
  )
  end

  def postal_code
    zip
  end

  def province
    state
  end
end
