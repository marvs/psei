# PSEI

This gem fetches the end-of-day values of the Philippine Stock Exchange (PSE).
More details available at their website [www.pse.com.ph](http://www.pse.com.ph/).

[![Gem Version](https://badge.fury.io/rb/psei.svg)](https://badge.fury.io/rb/psei)
[![Build Status](https://travis-ci.org/marvs/psei.png)](https://travis-ci.org/marvs/psei)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'psei'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install psei

## Usage

There are two main components in this library, the `Security` module and the `Index` module.

### Psei::Security

This module is used to get the end-of-day values of all securities in the PSE. The main identifier of these securities are their symbols or tickers. For example, the Philippine Long Distance Telephone Company is defined by their symbol `TEL`.

First, we need to initialize the module:

`@sec = Psei::Security.new`

To get the list of all symbols available:

`@sec.symbols`

This returns an array of all symbols (as strings), sorted by alphabetical order.

To get the values of a specific security:

`@sec.value('TEL')`

This returns a Hash containing the following information:

* symbol (String) - The security symbol 
* alias (String) - The company identifier 
* total_volume (Float) - Total number of traded volume of the day 
* updown (String) - Identifies if the security has gone up or down in value
* percent_change (Float) - Percentage that the security has changed
* last_price (Float) - The last traded price of the security

To get the values of all securities in a single call:

`@sec.values`

This returns an array of Hashes, each containing the same information when getting the values of a single security.

Note that these values are only applicable to a specific trading day. To get the date of these values:

`@sec.date`


### Psei::Index

This module is used to get the end-of-day values of all indices in the PSE. This includes the main index (PSEi), as well as industry-specific indices (Financial, Holdings, Mining, Services, etc).

First, we need to initialize the module:

`@ind = Psei::Index.new`

To get the list of all symbols available:

`@ind.symbols`

This returns an array of all symbols (as strings).

To get the values of a specific index:

`@ind.value('PSE')`

This returns a Hash containing the following information:

* symbol (String) - The index symbol 
* alias (String) - The index identifier 
* total_volume (Float) - Total number of traded volume of the day 
* updown (String) - Identifies if the index has gone up or down in value
* percent_change (Float) - Percentage that the index has changed
* last_price (Float) - The last traded price of the index

To get the values of all indices in a single call:

`@ind.values`

This returns an array of Hashes, each containing the same information when getting the values of a single index.

Note that these values are only applicable to a specific trading day. To get the date of these values:

`@ind.date`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marvs/psei. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

