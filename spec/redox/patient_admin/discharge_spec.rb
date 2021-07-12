# frozen_string_literal: true

RSpec.describe Redox::PatientAdmin::Discharge do
  it "supports Redox JSON" do
    json = IO.read "spec/data/patient-admin-discharge.json"

    discharge = Redox::PatientAdmin::Discharge.from_redox_json json

    expect(discharge.meta.event_type).to eq "Discharge"
    expect(discharge.patient.identifiers.first.id).to eq "0000000001"
  end
end
