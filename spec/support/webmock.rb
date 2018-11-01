require 'webmock/rspec'
require_relative 'fake_gitlab'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:any, /gitlab.com/).to_rack(FakeGitlab)
  end
end
