# frozen_string_literal: true

RSpec.describe Redox::Models::Meta do
  it "generates Redox JSON" do
    meta = Redox::Models::Meta.new(
      data_model: "model",
      event_type: "query",
      destinations: [Redox::Models::Destination.new(id: "id")]
    )
    expect(meta.to_redox_json).to eq_json %(
      {
        "DataModel": "model",
        "EventType": "query",
        "Destinations": [
          {
            "ID": "id"
          }
        ]
      }
    )
  end
end
