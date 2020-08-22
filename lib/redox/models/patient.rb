# frozen_string_literal: true

require_relative "patient_identifier"
require_relative "demographics"

module Redox
  module Models
    class Patient < Redox::Model
      redox_property :Identifiers, coerce: Array[PatientIdentifier]
      redox_property :Demographics, coerce: Demographics
    end
  end
end
