# frozen_string_literal: true

RSpec.describe Redox::PatientSearch::Query do
  let(:source) { create_source "test-api-key", "test-secret" }
  let(:destination_id) { "6310353a-eed7-44a1-b2bc-d017f4f33d64" }

  context "match" do
    it "returns result", :vcr do
      query = Redox::PatientSearch::Query.new(
        patient: Redox::Models::Patient.new(
          demographics: Redox::Models::Demographics.new(
            first_name: "Timothy",
            middle_name: "Paul",
            last_name: "Bixby",
            dob: "2008-01-06",
            ssn: "101-01-0001",
            sex: "Male",
            race: "White",
            address: Redox::Models::Address.new(
              street_address: "4762 Hickory Street",
              city: "Monroe",
              state: "WI",
              zip: "53566",
              county: "Green",
              country: "US"
            )
          )
        )
      )
      result = query.perform source, destination_id
      expect(result.patient.demographics.address.city).to eq "Monroe"
      expect(result.patient.identifiers).to eq [
        Redox::Models::PatientIdentifier.new(id_type: "MR", id: "0000000001"),
        Redox::Models::PatientIdentifier.new(
          id_type: "EHRID",
          id: "e167267c-16c9-4fe3-96ae-9cff5703e90a"
        ),
        Redox::Models::PatientIdentifier.new(id_type: "NIST", id: "a1d4ee8aba494ca")
      ]
    end
  end
end
