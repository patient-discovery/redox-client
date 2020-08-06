# frozen_string_literal: true

RSpec.describe Redox::Source do
  describe "ensure_access_token" do
    context "valid credentials" do
      subject { create_source "test-api-key", "test-secret" }
      it "saves the access token and its expiration time", :vcr do
        subject.ensure_access_token
        expect(subject.access_token).to eq("test-access-token")
        expect(subject.access_token_expires_at).to be > DateTime.now
      end
    end

    context "invalid credentials" do
      subject { create_source "test-api-key", "test-wrong-secret" }
      it "raises an error", :vcr do
        expect { subject.ensure_access_token }.to raise_error Redox::AuthenticationError
      end
    end

    context "has a token about to expire" do
      subject { create_source "test-api-key", "test-secret" }

      it "re-authenticates and saves the new token", :vcr do
        subject.instance_variable_set(:@access_token, "almost-expired-token")
        subject.instance_variable_set(:@access_token_expires_at, DateTime.now + 30)

        subject.ensure_access_token
        expect(subject.access_token).to eq("test-new-token")
      end
    end

    context "has valid access token" do
      subject { create_source "api-key", "secret" }

      it "does not make an HTTP request", :vcr do
        subject.access_token = "valid-token"
        subject.instance_variable_set(:@access_token_expires_at, DateTime.now + 3600)

        subject.ensure_access_token
        expect(subject.access_token).to eq("valid-token")
      end
    end
  end
end
