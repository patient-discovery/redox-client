# frozen_string_literal: true

RSpec.describe Redox::Source do
  describe "ensure_access_token" do
    context "valid credentials" do
      subject { create_source }
      it "saves the access token and its expiration time", :vcr do
        subject.ensure_access_token
        expect(subject.access_token).to eq("test-access-token")
        expect(subject.access_token_expires_at).to be > DateTime.now
        expect(subject.token_expiring_soon?).to be(false)
      end
    end

    context "invalid credentials" do
      subject { create_source api_key: "test-api-key", secret: "test-wrong-secret" }
      it "raises an error", :vcr do
        expect { subject.ensure_access_token }.to raise_error Redox::AuthenticationError
      end
    end

    context "has a token about to expire" do
      subject { create_source }

      it "re-authenticates and saves the new token", :vcr do
        subject.instance_variable_set(:@access_token, "almost-expired-token")
        subject.instance_variable_set(:@access_token_expires_at, add_seconds(DateTime.now, 30))
        expect(subject.token_expiring_soon?).to be(true)
        subject.ensure_access_token
        expect(subject.access_token).to eq("test-new-token")
      end
    end

    context "has valid access token" do
      subject { create_source api_key: "api-key", secret: "secret" }

      it "does not make an HTTP request", :vcr do
        subject.access_token = "valid-token"
        subject.instance_variable_set(:@access_token_expires_at, add_seconds(DateTime.now, 3600))

        subject.ensure_access_token
        expect(subject.access_token).to eq("valid-token")
      end
    end
  end
end

def add_seconds(datetime, seconds)
  datetime + Rational(seconds, 60 * 60 * 24)
end
