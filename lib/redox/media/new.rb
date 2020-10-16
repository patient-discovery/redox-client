# frozen_string_literal: true

require "redox"

module Redox
  module Media
    class New < Redox::Query
      redox_property :Patient, coerce: Models::Patient
      redox_property :Visit, coerce: Models::Visit
      redox_property :Media, coerce: Models::Media

      def response_type
        NewResponse
      end
    end

    class NewResponse < Models::Message
    end
  end
end
