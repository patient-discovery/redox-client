# frozen_string_literal: true

require_relative "observer"
require_relative "reference_range"

module Redox
  module Models
    class Observation < Redox::Model
      redox_property :DateTime
      redox_property :Value
      redox_property :ValueType
      redox_property :Units
      redox_property :Code
      redox_property :Codeset
      redox_property :Description
      redox_property :Status
      redox_property :Notes, coerce: Array[String]
      redox_property :Observer, coerce: Observer
      redox_property :ReferenceRange, coerce: ReferenceRange
      redox_property :AbnormalFlag
    end
  end
end
