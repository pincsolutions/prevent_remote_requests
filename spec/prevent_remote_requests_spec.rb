require 'spec_helper'

describe PreventRemoteRequests::Middleware do
  include Rack::Test::Methods


    [200, {'Content-Type' => 'text/plain'}, ['All good!'] ]


  def mock_app_with_config
    target_app = mock("Target Rack Application with a config")
    target_app.
      stub!(:call).
      and_return([200, { }, "Target app"])

    allowed = {'192.168.33.0' => 24, '192.168.34.0' => 24}

    prr = mock("False PRR")
    prr.stub!(:allowed).and_return(allowed)

    config = mock("False Config")
    config.stub!(:prevent_remote_requests).
      and_return(prr)

    target_app.
      stub!(:config).
      and_return(config)

    target_app
  end
  def mock_app_without_config
    target_app = mock("Target Rack Application with no config")
    target_app.
      stub!(:call).
      and_return([200, { }, "Target app"])
    target_app.
      stub!(:config).
      and_return(nil)

    target_app
  end

    context "with no config" do

      before do
        def app
          PreventRemoteRequests::Middleware.new(mock_app_without_config)
        end
      end

      it 'lets my local request through' do
        request('/')
        last_response.should be_ok
      end
      it 'does not let my remote request through' do
        request('/', {'REMOTE_ADDR' => '192.168.110.100'})
        last_response.status.should == 403
      end
    end

    context "with config" do

      before do
        def app
          PreventRemoteRequests::Middleware.new(mock_app_with_config)
        end
      end

      it 'lets my local request through' do
        request('/', {'REMOTE_ADDR' => '192.168.33.12'})
        last_response.should be_ok
      end

      it 'returns a 403 forbidden for a non-local request' do
        puts app.inspect

        request('/', {'REMOTE_ADDR' => '192.168.110.100'})
        last_response.status.should == 403
      end
    end
end
