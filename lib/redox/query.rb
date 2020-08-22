# frozen_string_literal: true

require "date"

module Redox
  class Query < Models::Message
    def perform(source, destination_id)
      data_model, event_type = self.class.name.split("::").drop(1)
      self.meta = {
        data_model: data_model,
        event_type: event_type,
        event_date_time: DateTime.now.iso8601,
        destinations: [Redox::Models::Destination.new(id: destination_id)]
      }
      result_body = source.execute_query self
      response = response_type.from_redox_json result_body
      response._body = result_body
      response
    end
  end
end
