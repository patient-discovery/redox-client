# frozen_string_literal: true

module Redox
  class FileUpload
    ENDPOINT = "https://blob.redoxengine.com/upload"

    # Create a multipart file upload.
    #
    # @param filename_or_io [String, IO] Either a String filename of a local file
    # or an open IO object
    # @param content_type [String] String content type of the file data
    # @param upload_as_filename [String] (optional) Name to use for uploaded file
    def initialize(filename_or_io, content_type, upload_as_filename = nil)
      @file_part = Faraday::FilePart.new(filename_or_io, content_type, upload_as_filename)
    end

    # Upload the file.
    #
    # @param [Redox::Source] source to use for authentication
    def perform(source)
      source.ensure_access_token

      connection = Faraday.new { |f|
        f.authorization :Bearer, source.access_token
        f.request :multipart
        f.headers[:accept] = "application/json"
      }
      res = connection.post ENDPOINT, {file: @file_part}

      raise Redox::Error.new(status: res.status, body: res.body) unless res.success?

      uri =
        begin
          JSON.parse(res.body)["URI"]
        rescue
        end
      raise Redox::Error.new(status: res.status, body: res.body) unless uri

      uri
    end
  end
end
