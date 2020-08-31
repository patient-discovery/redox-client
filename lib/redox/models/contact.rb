# frozen_string_literal: true

require_relative "address"
require_relative "phone_number"

module Redox
  module Models
    class Contact < Redox::Model
      redox_property :FirstName
      redox_property :MiddleName
      redox_property :LastName
      redox_property :Address, coerce: Address
      redox_property :PhoneNumber, coerce: PhoneNumber
      redox_property :EmailAddresses, coerce: Array[String]
      redox_property :RelationToPatient
      redox_property :Roles, coerce: Array[String]
    end
  end
end
