# frozen_string_literal: true

RSpec.describe Redox::Models::PatientIdentifier do
  subject { Redox::Models::PatientIdentifier.new id_type: "foo", id: 42 }
  it "generates Redox JSON" do
    expect(subject.to_redox_json).to eq_json %(
      {
        "IDType": "foo",
        "ID": 42
      }
    )
  end
end
