# frozen_string_literal: true

require "redox"

module Redox
  module Scheduling
    class Booked < Redox::Query
      redox_property :StartDateTime, coerce: ->(v) {
        v.respond_to?(:iso8601) ? v.iso8601 : v.to_s
      }
      redox_property :EndDateTime, coerce: ->(v) {
        v.respond_to?(:iso8601) ? v.iso8601 : v.to_s
      }

      def response_type
        BookedResponse
      end
    end

    class BookedResponse < Models::Message
      redox_property :Visits, coerce: Array[Models::Visit]
    end
  end
end
