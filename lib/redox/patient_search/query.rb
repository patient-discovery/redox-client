# frozen_string_literal: true

require "redox"

module Redox
  module PatientSearch
    class Query < Redox::Query
      redox_property :Patient, coerce: Models::Patient

      def response_type
        Response
      end
    end

    class Response < Models::Message
      redox_property :Patient, coerce: Models::Patient
    end
  end
end
