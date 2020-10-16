# frozen_string_literal: true

require "base64"

RSpec.describe Redox::Media::New do
  let(:source) { create_source endpoint: "https://api.redoxengine.com" }
  let(:destination_id) { "af394f14-b34a-464f-8d24-895f370af4c9" }

  it "succeeds", :vcr do
    query = Redox::Media::New.new(
      patient: Redox::Models::Patient.new(
        identifiers: [
          Redox::Models::PatientIdentifier.new(id_type: "MR", id: "42")
        ]
      ),
      visit: Redox::Models::Visit.new(visit_number: 42),
      media: Redox::Models::Media.new(
        file_type: "TEXT",
        file_name: "hello.txt",
        file_contents: Base64.encode64("hello\n"),
        document_type: "Greeting",
        document_id: "42",
        provider: Redox::Models::Provider.new(id: "provider-1"),
        availability: "Available"
      )
    )
    result = query.perform source, destination_id
    expect(result.meta.message.id).to eq 4242
  end
end
