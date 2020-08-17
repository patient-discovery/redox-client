# frozen_string_literal: true

module Redox
  module Models
    class Error < Redox::Model
      redox_property :ID
      redox_property :Text
      redox_property :Type
      redox_property :Module
    end
  end
end
