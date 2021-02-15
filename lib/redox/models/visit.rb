# frozen_string_literal: true

require_relative "location"
require_relative "patient"
require_relative "provider"

module Redox
  module Models
    class Visit < Redox::Model
      redox_property :VisitNumber
      redox_property :AccountNumber
      redox_property :VisitDateTime
      redox_property :PatientClass
      redox_property :Status
      redox_property :Duration
      redox_property :Reason
      redox_property :CancelReason
      redox_property :LastUpdated
      redox_property :ScheduledDateTime
      redox_property :CancelDateTime
      redox_property :Type
      redox_property :Instructions
      redox_property :Patient, coerce: Patient
      redox_property :Patients, coerce: Array[Patient]
      redox_property :AttendingProvider, coerce: Provider
      redox_property :ConsultingProvider, coerce: Provider
      redox_property :ReferringProvider, coerce: Provider
      redox_property :VisitProvider, coerce: Provider
      redox_property :Location, coerce: Location
    end
  end
end
