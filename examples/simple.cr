require "../src/geocoder"

# "1060 West Addison? That's Wrigley Field!" — Jake Blues
Geocoder.search("1060 W Addison, Chicago, IL").each do |result|
  puts result
  puts result.apple_maps_url
  puts result.google_maps_url
end
