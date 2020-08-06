# frozen_string_literal: true

require_relative "patient_identifier"
require_relative "demographics"

class Redox::Models::Patient < Redox::Model
  redox_property :Identifiers, coerce: Array[Redox::Models::PatientIdentifier]
  redox_property :Demographics, coerce: Redox::Models::Demographics
end
