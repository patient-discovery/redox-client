# frozen_string_literal: true

RSpec.describe Redox::PatientSearch::Query do
  let(:source) { create_source }
  let(:destination_id) { "6310353a-eed7-44a1-b2bc-d017f4f33d64" }

  context "match" do
    it "returns result", :vcr do
      query = Redox::PatientSearch::Query.new(
        patient: Redox::Models::Patient.new(
          demographics: Redox::Models::Demographics.new(
            first_name: "Timothy",
            last_name: "Bixby",
            dob: "2008-01-06",
            address: Redox::Models::Address.new(zip: "53566")
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

  context "no match" do
    it "returns result with empty Patient", :vcr do
      query = Redox::PatientSearch::Query.new(
        patient: Redox::Models::Patient.new(
          demographics: Redox::Models::Demographics.new(
            first_name: "Tim",
            last_name: "Bixby",
            dob: "2008-01-06",
            address: Redox::Models::Address.new(zip: "53566")
          )
        )
      )
      result = query.perform source, destination_id
      expect(result.patient.identifiers).to be nil
    end
  end

  context "incomplete search criteria" do
    it "raises with redox error data", :vcr do
      query = Redox::PatientSearch::Query.new(
        patient: Redox::Models::Patient.new(
          demographics: Redox::Models::Demographics.new(
            last_name: "Bixby",
            address: Redox::Models::Address.new(zip: "53566")
          )
        )
      )
      expect {
        query.perform source, destination_id
      }.to raise_error do |error|
        expect(error).to be_a(Redox::Error)
        expect(error.message.meta.errors).to have_at_least(1).item
      end
    end
  end
end
