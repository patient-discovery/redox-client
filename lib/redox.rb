# frozen_string_literal: true

require_relative "redox/version"

require_relative "redox/model"
require_relative "redox/models/address"
require_relative "redox/models/demographics"
require_relative "redox/models/destination"
require_relative "redox/models/error"
require_relative "redox/models/location"
require_relative "redox/models/message"
require_relative "redox/models/meta"
require_relative "redox/models/patient_identifier"
require_relative "redox/models/patient"
require_relative "redox/models/phone_number"
require_relative "redox/models/provider"
require_relative "redox/models/visit"

require_relative "redox/query"
require_relative "redox/source"
require_relative "redox/patient_search/query.rb"
require_relative "redox/scheduling/booked.rb"

module Redox
  class Error < StandardError
    attr_accessor :status
    attr_accessor :body
    attr_accessor :message

    def initialize(status: nil, body: nil, message: nil)
      self.status = status
      self.body = body
      self.message = message
    end
  end

  class AuthenticationError < Error; end
end
