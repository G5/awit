# Awit

Thin wrapper around [Typhoeus](typhoeus) to make communication with OAuth-protected APIs easier.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'awit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install awit

## Usage

Setup an initializer to let Awit know how to fetch the bearer token:

```ruby
Awit.configure do |config|
  # This must be set
  config.auth_token = { MyAuthClient.new.get_access_token }

  # These are optional
  config.content_type = "application/javascript" # defaults to "application/json"
  config.accept = "application/javascript" # defaults to "application/json"
end
```

Then, in your app:

```
Awit.post("https://other-app.com/api/v1/jobs", {body: "here"})
Awit.get("https://other-app.com/api/v1/jobs/1")
Awit.delete("https://other-app.com/api/v1/jobs/1")
Awit.put("https://other-app.com/api/v1/jobs/1", {something: "else"})
```

A [Typhoeus](typhoeus) response is returned by the `post`, `get`, `delete`, and `put` methods above.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/awit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

  [typhoeus]: https://github.com/typhoeus/typhoeus
