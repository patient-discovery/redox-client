# frozen_string_literal: true

RSpec.describe Redox::Model do
  describe "to_redox_json" do
    it "generates Redox JSON" do
      demographics = Redox::Models::Demographics.new(
        first_name: "Luke",
        last_name: "Skywalker",
        dob: "2008-01-06",
        ssn: "101-01-0001",
        sex: "Male"
      )
      demographics.address = Redox::Models::Address.new(
        street_address: "1 Main St",
        city: "Tatooine",
        state: "IL",
        zip: "12345"
      )

      expect(demographics.to_redox_json).to eq_json %(
        {
          "FirstName": "Luke",
          "LastName": "Skywalker",
          "DOB": "2008-01-06",
          "SSN": "101-01-0001",
          "Sex": "Male",
          "Address": {
            "StreetAddress": "1 Main St",
            "City": "Tatooine",
            "State": "IL",
            "ZIP": "12345"
          }
        }
      )
    end
  end
end
