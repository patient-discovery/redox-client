# frozen_string_literal: true

require_relative "redox/version"

require_relative "redox/model"
require_relative "redox/models/address"
require_relative "redox/models/demographics"
require_relative "redox/models/destination"
require_relative "redox/models/message"
require_relative "redox/models/meta"
require_relative "redox/models/patient"
require_relative "redox/models/patient_identifier"

require_relative "redox/query"
require_relative "redox/source"
require_relative "redox/patient_search/query.rb"

module Redox
  class Error < StandardError; end
  class AuthenticationError < Error; end
end
