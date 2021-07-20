# frozen_string_literal: true

module Redox
  module Models
    class Specimen < Redox::Model
      redox_property :Source
      redox_property :BodySite
      redox_property :ID
    end
  end
end
