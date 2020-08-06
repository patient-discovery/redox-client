# frozen_string_literal: true

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
task test: [:rubocop, :standard, :check_vcr_cassettes, :spec]

desc "Fix RuboCop and StandardRB violations"
task fix: ["rubocop:auto_correct", "standard:fix"]

desc "Check VCR cassettes for Redox credential leak"
task :check_vcr_cassettes do
  # TODO: Make this a proper lib/rake_tasks.rb task and avoid exec'ing out
  raise "Possible credential leak" unless system "bin/check-vcr-cassettes"
end

CLEAN.include "coverage"
