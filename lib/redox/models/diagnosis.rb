# frozen_string_literal: true

module Redox
  module Models
    class Diagnosis < Redox::Model
      redox_property :Code
      redox_property :Codeset
      redox_property :Name
      redox_property :Type
      redox_property :DocumentedDateTime
    end
  end
end
