# frozen_string_literal: true

require_relative "patient_identifier"
require_relative "demographics"
require_relative "contact"

module Redox
  module Models
    class Patient < Redox::Model
      redox_property :Identifiers, coerce: Array[PatientIdentifier]
      redox_property :Demographics, coerce: Demographics
      redox_property :Contacts, coerce: Array[Contact]
    end
  end
end
