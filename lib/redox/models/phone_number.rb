# frozen_string_literal: true

module Redox
  module Models
    class PhoneNumber < Redox::Model
      redox_property :Home
      redox_property :Office
      redox_property :Mobile
    end
  end
end
