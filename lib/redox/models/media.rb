# frozen_string_literal: true

require_relative "provider"

module Redox
  module Models
    class Media < Redox::Model
      redox_property :FileType
      redox_property :FileName
      redox_property :FileContents
      redox_property :DocumentType
      redox_property :DocumentID
      redox_property :DocumentDescription
      redox_property :CreationDateTime
      redox_property :ServiceDateTime
      redox_property :Provider, coerce: Provider
      redox_property :Authenticated
      redox_property :Authenticator, coerce: Provider
      redox_property :Availability
      redox_property :Notifications, coerce: Array[Provider]
    end
  end
end
