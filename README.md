# PreventRemoteRequests

Rack middleware for blocking remote requests

## Installation

Add this line to your application's Gemfile:

    gem 'prevent_remote_requests'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prevent_remote_requests



## Usage

Add the middleware to your rack application in the usual way. Rails you could do this:

      # config/application.rb
      config.middleware.use PreventRemoteRequsts::Middleware


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
