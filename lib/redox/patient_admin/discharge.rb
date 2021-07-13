# frozen_string_literal: true

require "redox"

module Redox
  module PatientAdmin
    class Discharge < Models::Message
      redox_property :Patient, coerce: Models::Patient
      redox_property :Visit, coerce: Models::Visit
    end
  end
end
