# frozen_string_literal: true

module Redox
  module Models
    class Address < Redox::Model
      redox_property :StreetAddress
      redox_property :City
      redox_property :State
      redox_property :ZIP
      redox_property :County
      redox_property :Country
    end
  end
end
