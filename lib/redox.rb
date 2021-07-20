# frozen_string_literal: true

require_relative "redox/version"

require_relative "redox/model"
require_relative "redox/models/address"
require_relative "redox/models/clinical_info"
require_relative "redox/models/contact"
require_relative "redox/models/demographics"
require_relative "redox/models/destination"
require_relative "redox/models/diagnosis"
require_relative "redox/models/error"
require_relative "redox/models/location"
require_relative "redox/models/media"
require_relative "redox/models/message"
require_relative "redox/models/meta"
require_relative "redox/models/observation"
require_relative "redox/models/observer"
require_relative "redox/models/order"
require_relative "redox/models/ordering_facility"
require_relative "redox/models/patient_identifier"
require_relative "redox/models/patient"
require_relative "redox/models/phone_number"
require_relative "redox/models/procedure"
require_relative "redox/models/provider"
require_relative "redox/models/reference_range"
require_relative "redox/models/visit"

require_relative "redox/source"
require_relative "redox/query"
require_relative "redox/file_upload"

require_relative "redox/patient_admin/discharge.rb"
require_relative "redox/patient_search/query.rb"
require_relative "redox/scheduling/booked.rb"
require_relative "redox/media/new.rb"
require_relative "redox/flowsheet/new.rb"
require_relative "redox/order/new.rb"

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
