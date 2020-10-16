# frozen_string_literal: true

RSpec.describe Redox::Query do
  let(:source) { create_source }
  let(:destination_id) { "6310353a-eed7-44a1-b2bc-d017f4f33d64" }

  it "includes _body in returned response", :vcr do
    query = Redox::PatientSearch::Query.new(
      patient: Redox::Models::Patient.new(
        demographics: Redox::Models::Demographics.new(
          first_name: "Unknown",
          last_name: "Person",
          dob: "01-01-01",
          address: Redox::Models::Address.new(zip: "11111")
        )
      )
    )
    result = query.perform source, destination_id
    expect(result._body).to include "Patient"
  end
end
