# frozen_string_literal: true

module Redox
  module Models
    class ReferenceRange < Redox::Model
      redox_property :Low
      redox_property :High
      redox_property :Text
    end
  end
end
