# frozen_string_literal: true

require_relative "address"

module Redox
  module Models
    class Demographics < Redox::Model
      redox_property :FirstName
      redox_property :MiddleName
      redox_property :LastName
      redox_property :DOB
      redox_property :SSN
      redox_property :Sex
      redox_property :Address, coerce: Address
    end
  end
end
