require "prevent_remote_requests/version"

module PreventRemoteRequests
  class Middleware
    def initialize(app)
        @app = app
    end

    def call(env)
      puts env.inspect
      env['REMOTE_ADDR'] == '127.0.0.1' ? @app.call(env) : [403, {}, ['External requests are forbidden.']]
    end
  end
end
