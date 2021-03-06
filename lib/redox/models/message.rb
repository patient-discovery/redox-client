# frozen_string_literal: true

require_relative "meta"

module Redox
  module Models
    class Message < Redox::Model
      attr_accessor :_body
      redox_property :Meta, coerce: Redox::Models::Meta
    end
  end
end
