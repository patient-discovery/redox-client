# frozen_string_literal: true

require "date"
require "json"
require "faraday"

class Redox::Source
  include MonitorMixin

  ACCESS_TOKEN_EXPIRATION_BUFFER_SECONDS = 300

  attr_reader :access_token_expires_at

  def initialize(endpoint:, api_key:, secret:, test_mode: true)
    super()
    @connection = Faraday.new(
      url: endpoint,
      headers: {
        accept: "application/json",
        content_type: "application/json"
      }
    )
    @api_key = api_key
    @secret = secret
    @test_mode = test_mode
  end

  def execute_query(model)
    ensure_access_token
    res = @connection.post("/endpoint", model.to_redox_json)
    message =
      begin
        JSON.parse(res.body)
      rescue
        nil
      end

    unless res.success?
      raise Redox::Error.new(
        status: res.status,
        body: res.body,
        message: Redox::Models::Message.from_redox_json(message)
      )
    end
    message
  end

  def ensure_access_token
    synchronize {
      authenticate if access_token.nil? || token_expiring_soon?
    }
  end

  def access_token
    @connection.headers["Authorization"]&.delete_prefix "Bearer "
  end

  def access_token=(token)
    if token.nil?
      @connection.headers.delete "Authorization"
    else
      @connection.authorization :Bearer, token
    end
  end

  private

  def token_expiring_soon?
    DateTime.now > @access_token_expires_at - ACCESS_TOKEN_EXPIRATION_BUFFER_SECONDS
  end

  def authenticate
    self.access_token = nil
    res = @connection.post("/auth/authenticate", {apiKey: @api_key, secret: @secret}.to_json)
    raise Redox::AuthenticationError.new status: res.status, body: res.body unless res.success?
    data = JSON.parse(res.body)
    self.access_token = data["accessToken"]
    @access_token_expires_at = DateTime.parse(data["expires"])
  end
end
