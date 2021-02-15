# frozen_string_literal: true

require_relative "lib/redox/version"

Gem::Specification.new do |gem|
  gem.name = "redox-client"
  gem.version = Redox::VERSION
  gem.homepage = "https://github.com/patient-discovery/redox-client"
  gem.authors = ["Michael Keirnan"]
  gem.email = ["mike@patientdiscovery.com"]

  gem.summary = "Ruby library for consuming Redox JSON APIs"
  gem.required_ruby_version = Gem::Requirement.new(">= 2.6.0")
  gem.metadata["source_code_uri"] = gem.homepage
  gem.metadata["changelog_uri"] = "#{gem.homepage}/blob/main/CHANGELOG.md"

  gem.license = "MIT"
  gem.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{(^spec|^bin|^\.)}) }
  end
  gem.require_paths = ["lib"]

  gem.add_development_dependency "debase", "~> 0.2.4.1"
  gem.add_development_dependency "rake", "~> 12.0"
  gem.add_development_dependency "ruby-debug-ide", "~> 0.7.2"
  gem.add_development_dependency "rspec", "~> 3.9"
  gem.add_development_dependency "rspec-collection_matchers", "~> 1.2"
  gem.add_development_dependency "simplecov", "~> 0.18.5"
  gem.add_development_dependency "standard", "~> 0.4.7"
  gem.add_development_dependency "vcr", "~> 6.0"

  gem.add_runtime_dependency "faraday", "~> 1.0", ">= 1.0.1"
  gem.add_runtime_dependency "hashie", "~> 4.1"
end
