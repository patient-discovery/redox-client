# frozen_string_literal: true

module Redox
  module Models
    class Observer < Redox::Model
      redox_property :ID
      redox_property :IDType
      redox_property :FirstName
      redox_property :LastName
    end
  end
end
