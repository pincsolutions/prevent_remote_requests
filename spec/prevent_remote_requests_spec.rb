require 'spec_helper'

describe PreventRemoteRequests::Middleware do
  include Rack::Test::Methods


    [200, {'Content-Type' => 'text/plain'}, ['All good!'] ]


  let(:app) {
    target_app = mock("Target Rack Application")
      target_app.
        stub!(:call).
        and_return([200, { }, "Target app"])
    PreventRemoteRequests::Middleware.new(target_app)
  }

    it 'lets my local request through' do
      request('/')
      last_response.should be_ok
    end

    it 'returns a 403 forbidden for a non-local request' do
      request('/', {'REMOTE_ADDR' => '192.168.110.100'})
      last_response.status.should == 403
    end
end
