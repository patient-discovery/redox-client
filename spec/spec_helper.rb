# frozen_string_literal: true

require "rspec/expectations"
require "rspec/collection_matchers"
require "bundler/setup"
require "base64"
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

# Parse JSON string or base64 encoded JSON string
def decode_and_parse_json(string)
  JSON.parse(string)
rescue
  JSON.parse(Base64.decode64(string))
end

def vcr_recording?
  ENV["VCR_MODE"] == "record"
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
  rescue
    actual == expected
  end

  vcr.default_cassette_options = {
    record: vcr_recording? ? :all : :once,
    record_on_error: false,
    match_requests_on: %i[method uri body_without_event_date_time],
    erb: true
  }

  {
    "apiKey" => "test-api-key",
    "secret" => "test-secret"
  }.each do |original, replacement|
    vcr.filter_sensitive_data(replacement) do |interaction|
      decode_and_parse_json(interaction.request.body)[original]
    rescue
    end
  end

  {
    "accessToken" => "test-access-token",
    "refreshToken" => "test-refresh-token",
    "expires" => "<%= DateTime.now + 1 %>"
  }.each do |original, replacement|
    vcr.filter_sensitive_data(replacement) do |interaction|
      decode_and_parse_json(interaction.response.body)[original]
    rescue
    end
  end

  vcr.filter_sensitive_data("Bearer test-access-token") do |interaction|
    interaction.request.headers["Authorization"]&.first
  end

  vcr.debug_logger = File.open("vcr-debug.log", "w") if ENV["VCR_DEBUG"]

  vcr.configure_rspec_metadata!
end

RSpec::Matchers.define :eq_json do |expected|
  match do |actual|
    JSON.parse(expected) == JSON.parse(actual)
  end
  diffable
end

def create_source(
  endpoint: "https://candi.redoxengine.com",
  api_key: "test-api-key",
  secret: "test-secret"
)
  if vcr_recording?
    Redox::Source.new(
      endpoint: ENV["REDOX_ENDPOINT"],
      api_key: ENV["REDOX_API_KEY"],
      secret: ENV["REDOX_SECRET"],
      test_mode: true
    )
  else
    Redox::Source.new(
      endpoint: endpoint,
      api_key: api_key,
      secret: secret,
      test_mode: true
    )
  end
end
