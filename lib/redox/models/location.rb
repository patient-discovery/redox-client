# frozen_string_literal: true

module Redox
  module Models
    class Location < Redox::Model
      redox_property :Type
      redox_property :Facility
      redox_property :Department
      redox_property :Room
    end
  end
end
