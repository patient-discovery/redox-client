# frozen_string_literal: true

require "rspec/expectations"
require "bundler/setup"
require "redox"
require "json"
require "vcr"
require "simplecov"

SimpleCov.start

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |vcr|
  vcr.cassette_library_dir = "spec/cassettes"
  vcr.hook_into :faraday
  vcr.register_request_matcher :body_without_event_date_time do |actual_request, expected_request|
    actual = JSON.parse actual_request.body
    expected = JSON.parse expected_request.body

    if actual.key? "Meta"
      actual["Meta"].delete "EventDateTime"
      expected["Meta"].delete "EventDateTime"
    end
    actual == expected
  end
  vcr.default_cassette_options = {
    record: :once,
    match_requests_on: %i[method uri body_without_event_date_time],
    erb: true
  }
  vcr.configure_rspec_metadata!
end

RSpec::Matchers.define :eq_json do |expected|
  match do |actual|
    JSON.parse(expected) == JSON.parse(actual)
  end
  diffable
end

def create_source(api_key, secret)
  Redox::Source.new(
    endpoint: "https://candi.redoxengine.com",
    api_key: ENV["REDOX_API_KEY"] || api_key,
    secret: ENV["REDOX_SECRET"] || secret,
    test_mode: true
  )
end
