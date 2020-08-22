# frozen_string_literal: true

require_relative "address"
require_relative "location"
require_relative "phone_number"

module Redox
  module Models
    class Provider < Redox::Model
      redox_property :ID
      redox_property :IDType
      redox_property :FirstName
      redox_property :LastName
      redox_property :Credentials, coerce: Array[String]
      redox_property :Address, coerce: Address
      redox_property :EmailAddresses, coerce: Array[String]
      redox_property :PhoneNumber, coerce: PhoneNumber
      redox_property :Location, coerce: Location
    end
  end
end
