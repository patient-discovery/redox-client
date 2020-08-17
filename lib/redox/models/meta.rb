# frozen_string_literal: true

require_relative "destination"

module Redox
  module Models
    class Meta < Redox::Model
      redox_property :DataModel
      redox_property :EventType
      redox_property :EventDateTime
      redox_property :Test
      redox_property :Destinations, coerce: Array[Redox::Models::Destination]
      redox_property :Errors, coerce: Array[Redox::Models::Error]
    end
  end
end
