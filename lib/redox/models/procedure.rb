# frozen_string_literal: true

module Redox
  module Models
    class Procedure < Redox::Model
      redox_property :Code
      redox_property :Codeset
      redox_property :Description
    end
  end
end
