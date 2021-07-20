# frozen_string_literal: true

require_relative "address"

module Redox
  module Models
    class OrderingFacility < Redox::Model
      redox_property :Name
      redox_property :Address, coerce: Address
      redox_property :PhoneNumber
    end
  end
end
