# frozen_string_literal: true

module Redox
  module Models
    class PatientIdentifier < Redox::Model
      redox_property :IDType
      redox_property :ID
    end
  end
end
