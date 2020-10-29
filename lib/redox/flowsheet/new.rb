# frozen_string_literal: true

require "redox"

module Redox
  module Flowsheet
    class New < Models::Message
      redox_property :Patient, coerce: Models::Patient
      redox_property :Visit, coerce: Models::Visit
      redox_property :Observations, coerce: Array[Models::Observation]
    end
  end
end
