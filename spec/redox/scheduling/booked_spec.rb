# frozen_string_literal: true

RSpec.describe Redox::Scheduling::Booked do
  let(:source) { create_source }
  let(:destination_id) { "0a07ac7c-577d-46b8-865f-1a75a7dfcd12" }

  describe "matching results" do
    it "returns results", :vcr do
      query = Redox::Scheduling::Booked.new(
        start_date_time: DateTime.new(2016, 1, 1)
      )
      result = query.perform source, destination_id
      expect(result.visits.length).to eq 187
      visits = result.visits.map { |v| [v.visit_number, v] }.to_h

      visit = visits["3514"]
      expect(visit.visit_number).to eq "3514"
      expect(visit.patient.identifiers).to eq [
        Redox::Models::PatientIdentifier.new(id_type: "MR", id: "0000000001"),
        Redox::Models::PatientIdentifier.new(
          id_type: "EHRID",
          id: "e167267c-16c9-4fe3-96ae-9cff5703e90a"
        ),
        Redox::Models::PatientIdentifier.new(id_type: "NIST", id: "a1d4ee8aba494ca")
      ]
      expect(visit.patient.demographics.phone_number.home).to eq "+18088675301"
      expect(visit.patient.demographics.email_addresses).to eq ["tim@example.net"]
      expect(visit.patient.contacts).to have(1).item
      expect(visit.location).to eq Redox::Models::Location.new(
        room: "136",
        department: "3N",
        type: "Inpatient",
        facility: "RES General Hospital"
      )
      expect(visit.visit_date_time).to eq "2020-06-05T19:05:33.154Z"
      expect(visit.attending_provider.id_type).to eq "NPI"
      expect(visit.attending_provider.id).to eq "4356789876"
      expect(visit.attending_provider.first_name).to eq "Pat"
      expect(visit.attending_provider.last_name).to eq "Granite"
      expect(visit.attending_provider.phone_number.office).to eq "+16085551234"
    end
  end

  describe "no match" do
    it "returns results with empty Array of visits", :vcr do
      query = Redox::Scheduling::Booked.new(
        start_date_time: DateTime.new(1984, 1, 1),
        end_date_time: DateTime.new(1984, 1, 2)
      )
      result = query.perform source, destination_id
      expect(result.visits).to eq []
    end
  end

  describe "querying for a specific patient", :vcr do
    it "returns visits for that patient" do
      query = Redox::Scheduling::Booked.new(
        start_date_time: DateTime.new(2020, 1, 1),
        end_date_time: DateTime.new(2022, 1, 1),
        visit: Redox::Models::Visit.new(
          patients: [
            Redox::Models::Patient.new(
              identifiers: [
                Redox::Models::PatientIdentifier.new(
                  id_type: "ST01", id: "60067224"
                )
              ]
            )
          ]
        )
      )

      result = query.perform source, destination_id
      expect(result.visits.map(&:visit_number)).to eq(["9841"])
    end
  end
end
