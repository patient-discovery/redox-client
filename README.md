[![Gem Version](https://img.shields.io/gem/v/redox-client.svg)](https://badge.fury.io/rb/redox-client)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)
![Test](https://github.com/patient-discovery/redox-client/workflows/Test/badge.svg)

# redox-client - Ruby gem facade for Redox APIs

This gem makes it easy to consume [Redox APIs](https://developer.redoxengine.com/).

*Note: This is pre-release software under active development and should be considered unstable until version 1.0.0*

## Features
 - supports creation of multiple Redox Sources, each with its own API key and secret
 - automatically requests Redox access tokens when needed in a thread safe way
 - provides ruby style [DTOs](https://en.wikipedia.org/wiki/Data_transfer_object) to conveniently consume and generate Redox camel cased JSON

## Installation

Add the following to your `Gemfile`:

```ruby
gem "redox-client"
```

and run:

```bash
bundle install
```

## Usage
To uses redox-client effectively you will want to be familiar with the [Redox APIs](https://developer.redoxengine.com/) and in particular how sources, destinations, and subscriptions work.

Create a Redox Source.

```ruby
source = Redox::Source.new(
    endpoint: ENV["REDOX_ENDPOINT"],
    api_key: ENV["REDOX_API_KEY"],
    secret: ENV["REDOX_SECRET"]
  )
```

Build query object for API you wish to execute:

```ruby
query = Redox::PatientSearch::Query.new(
  patient: Redox::Models::Patient.new(
    demographics: Redox::Models::Demographics.new(
      first_name: "Timothy",
      middle_name: "Paul",
      ...
    )
  )
)
```

Perform the query using your source and the appropriate destination id:

```ruby
result = query.perform source, "my-destination-id"
```

The result object is a DTO containing the Redox response:

```ruby
result.patient.identifiers.first.id_type   # => "MR"
result.patient.identifiers.first.id        # => "0000000001"
```

See the `specs/` for more examples.

### Authentication and Lifecycle
`Redox::Source` requests a Redox access token using the Redox API key and secret. The access token is used until it is near expiration, which is typically 1 day after being issued. So a `Redox::Source` object is intended to be created once and reused.

Since `Redox::Source` has shared state, i.e., the access token and its expiration time, `Redox::Source` uses a [Monitor](https://ruby-doc.org/stdlib-2.6.3/libdoc/monitor/rdoc/MonitorMixin.html) to be thread safe.


## Supported APIs

- PatientSearch.Query
- Scheduling.Booked
- Media.New
- File Upload

## Development
***Nota Bene**: This project uses [VCR](https://relishapp.com/vcr/vcr/docs) to record HTTP requests and responses and play them back during tests. Do NOT use Redox production credentials when developing tests.*

### Initial Setup
After checking out the repo, run `bin/setup` to install gem dependencies and a git pre-commit hook. The pre-commit hook checks test fixtures for Redox credential exposure. While recommended the hook is not required and can be removed or replaced if desired. After setup completes run `rake` to run all the tests.

### Testing
This project uses `rspec` and [VCR](https://relishapp.com/vcr/vcr/docs). VCR provides fast deterministic testing of HTTP APIs. It also makes it possible to set up any server response you want to test by authoring the server responses directly. This comes in handy when trying to test edge cases that might occur but are hard to reproduce.

Some effort has been made to filter credentials from recorded HTTP interactions, but you should always carefully review all your changes before pushing them to avoid credential exposure.

### Recording and Playing Back Cassettes
The `VCR_MODE` environment variable controls whether VCR is recording cassettes or playing them back. When recoding cassettes the following environment variables are used to call Redox APIs:

- `REDOX_ENDPOINT`: base URL of Redox API endpoint (e.g., https://api.redoxengine.com/)
- `REDOX_API_KEY`: Redox `apiKey` used by /auth/authenticate
- `REDOX_SECRET`: Redox `secret` used by /auth/authenticate

Set these to the credentials for the Redox environment you are using for testing.

When playing back cassettes these environment variables are ignored and no API requests are made to Redox.

To make a new test with a new recording, set environment variables above then:

```bash
env VCR_MODE=record rspec spec/my_new_spec.rb
```

This will record all API requests made by the test. Be **careful**: if you run all the tests with `VCR_MODE=record` it will re-record all the cassettes.

The default mode is playback, so to playback cassettes just run `rspec`.

### Coding Style
This project adheres to [StandardRB](https://github.com/testdouble/standard/blob/master/README.md). Additionally
[# frozen_string_literal](https://bugs.ruby-lang.org/issues/8976#note-30) is required in Ruby source files, and is enforced by Rubocop.

Run `rake` to run the style checks. Run `rake fix` to fix violations.

### Useful commands
- `rake` - run all tests (lint, Redox cred scan, rspec)
- `rake fix` - Fix RuboCop and StandardRB violations
- `rake vcr:fix` - attempt to replace real looking credentials in VCR cassettes with dummy test values.
- `rake -T` - see available rake tasks
- `bin/console` - get an interactive prompt for experimenting

### Release Process
This project uses [Semantic Versioning](https://semver.org)

Prepare release on master branch, then run:

```
rake prepare:release
```

and follow the instructions.
