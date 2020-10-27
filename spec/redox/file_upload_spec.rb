# frozen_string_literal: true

RSpec.describe Redox::FileUpload do
  before(:context) do
    @source = create_source "test-api-key", "test-secret"
    VCR.use_cassette("upload-authenticate") do
      @source.ensure_access_token
    end
  end

  describe "success" do
    it "returns the URI of uploaded file" do
      subject = Redox::FileUpload.new(StringIO.new("test"), "text/plain", "text.txt")
      VCR.use_cassette("upload-file-success", preserve_exact_body_bytes: true) do
        result = subject.perform @source
        expect(result).to eq("https://blob.redoxengine.com/14652614")
      end
    end
  end

  describe "400 response" do
    it "raises an error" do
      subject = Redox::FileUpload.new(StringIO.new("test"), "text/plain", "text.txt")
      VCR.use_cassette("upload-file-bad-request", preserve_exact_body_bytes: true) do
        expect { subject.perform @source }.to raise_error Redox::Error
      end
    end
  end
end
