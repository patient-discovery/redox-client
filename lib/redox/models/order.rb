# frozen_string_literal: true

require_relative "clinical_info"
require_relative "diagnosis"
require_relative "ordering_facility"
require_relative "procedure"
require_relative "provider"
require_relative "specimen"

module Redox
  module Models
    class Order < Redox::Model
      redox_property :ID
      redox_property :ApplicationOrderID
      redox_property :Status
      redox_property :TransactionDateTime
      redox_property :CollectionDateTime
      redox_property :Specimen, coerce: Specimen
      redox_property :Procedure, coerce: Procedure
      redox_property :Provider, coerce: Provider
      redox_property :ResultCopyProviders, coerce: Array[Provider]
      redox_property :OrderingFacility, coerce: OrderingFacility
      redox_property :Priority
      redox_property :Expiration
      redox_property :Comments
      redox_property :Notes, coerce: Array[String]
      redox_property :Diagnoses, coerce: Array[Diagnosis]
      redox_property :ClinicalInfo, coerce: Array[ClinicalInfo]
    end
  end
end
