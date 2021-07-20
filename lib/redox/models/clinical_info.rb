# frozen_string_literal: true

module Redox
  module Models
    class ClinicalInfo < Redox::Model
      redox_property :Code
      redox_property :Codeset
      redox_property :Description
      redox_property :Value
      redox_property :Units
      redox_property :Abbreviation
      redox_property :Notes, coerce: Array[String]
    end
  end
end
