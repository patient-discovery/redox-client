# frozen_string_literal: true

require "date"
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "standard/rake"
require "rubocop/rake_task"

RSpec::Core::RakeTask.new :spec
RuboCop::RakeTask.new :rubocop do |task|
  task.options = %w[--format quiet]
end

desc "Run all checks and tests"
task default: :test

desc "Run all checks and tests"
task test: [:rubocop, :standard, :vcr, :spec]

desc "Fix RuboCop and StandardRB violations"
task fix: ["rubocop:auto_correct", "standard:fix"]

# TODO: Make these a proper lib/rake_tasks.rb task and avoid exec'ing out
desc "Check VCR cassettes for Redox credential leak"
task "vcr" do
  raise "Possible credential leak, run rake vcr:fix" unless system "bin/check-vcr-cassettes"
end

desc "Scrub VCR cassettes, replacing suspected real creds with test ones"
task "vcr:fix" do
  system "bin/check-vcr-cassettes --scrub"
end

task "prepare:changelog" do
  repo = "https://github.com/patient-discovery/redox-client"
  changelog = IO.readlines("CHANGELOG.md").map(&:chomp)
  entries = [
    "## [#{Redox::VERSION}] - #{Date.today}",
    "[#{Redox::VERSION}]: #{repo}/releases/tag/v#{Redox::VERSION}",
    "[Unreleased]: #{repo}/compare/v#{Redox::VERSION}...HEAD"
  ]
  unless entries.all? { |x| changelog.include? x }
    puts "\nAdd these to CHANGELOG.md:\n\n"
    puts entries.join("\n")
    puts "\n\n"
    abort "ERROR: CHANGELOG version entries needed"
  end
  puts "CHANGELOG looks good"
end

task "prepare:version" do
  if system("git show-ref --tags v#{Redox::VERSION}")
    abort("ERROR: Tag already exists. Check version.rb")
  end
end

task "prepare:tag" do
  unless system("git tag -m 'Version #{Redox::VERSION}' v#{Redox::VERSION}")
    abort("ERROR: Unable to tag")
  end
end

task "prepare:release": [
  "release:guard_clean", "test", "prepare:version", "prepare:changelog", "prepare:tag"
] do
  puts "Release tagged. To create release run:\n\n"
  puts "git push --follow-tags"
end

CLEAN.include "coverage"
