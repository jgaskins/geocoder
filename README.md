# geocoder

Allows geocoding and reverse-geocoding using swappable backends for lookup.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     geocoder:
       github: jgaskins/geocoder
   ```

2. Run `shards install`

## Usage

```crystal
require "geocoder"

Geocoder.search "1060 W Addison, Chicago, IL"
# => [Geocoder::Result(@latitude=41.94818455, @longitude=-87.65555899980043)]
```

## Contributing

1. Fork it (<https://github.com/jgaskins/geocoder/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Jamie Gaskins](https://github.com/jgaskins) - creator and maintainer
