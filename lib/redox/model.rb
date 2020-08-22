# frozen_string_literal: true

require "hashie"
require "json"

module Redox::Models
end
class Redox::Model < Hashie::Trash
  include Hashie::Extensions::Dash::Coercion
  include Hashie::Extensions::IgnoreUndeclared

  def initialize(hash = {})
    if hash.keys.first.is_a? String
      hash = hash.transform_keys { |key|
        translated_key = self.class.translations[key.to_sym]
        translated_key.nil? ? key : translated_key
      }
    end
    super hash
  end

  def self.redox_property(redox_property, options = {})
    property to_snake_case(redox_property).to_sym, options.merge({from: redox_property})
  end

  def self.from_redox_json(json)
    case json
    when String
      json = JSON.parse json
    end
    new json.transform_keys(&:to_sym)
  end

  def to_redox_hash
    to_h
      .transform_keys { |k| self.class.inverse_translations[k] }
      .transform_values { |v| value_to_redox_hash(v) }
  end

  def value_to_redox_hash(value)
    if value.respond_to?(:to_redox_hash)
      value.to_redox_hash
    elsif value.is_a?(Array)
      value.map { |element| value_to_redox_hash(element) }
    else
      value
    end
  end

  def to_redox_json
    to_redox_hash.to_json
  end

  # Convert word from CamelCase to snake_case. This is roughly the same as the
  # rails `String.underscore` method with the following simplications:
  #
  # - any word in all caps is assumed to be an acronym (ZIP -> zip)
  # - only alphabetic characters are modified
  #
  # Note: this function does not have an inverse. Both "Zip" and "ZIP"
  # map to "zip".
  #
  # @param [String] camel_cased_word word to convert to snake case
  # @return [String] camel_cased_qord converted to snake case
  def self.to_snake_case(camel_cased_word)
    word = camel_cased_word.to_s
    return word.downcase if word.upcase == word

    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    word.downcase!
    word
  end
end
