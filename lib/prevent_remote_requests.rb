require 'prevent_remote_requests/version'
require 'ip_address'

module PreventRemoteRequests
  class Middleware
    def initialize(app)
      @app = app
      @allowed = app.config.prevent_remote_requests.allowed rescue {'127.0.0.1' => 32}
    end

    def call(env)
      raddr = IPAddress.new(env['REMOTE_ADDR'])
      @allowed.each_pair do |net, mask|
        return @app.call(env) if raddr/mask == IPAddress.new("#{net}/#{mask}")
      end
      [403, {}, ['External requests are forbidden.']]
    end
  end
end
