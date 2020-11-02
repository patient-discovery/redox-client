# Changelog

## [Unreleased]
### Added

### Changed

### Removed

## [0.5.0] - 2020-10-29
### Added
- File Upload
- Media.New

### Changed
- fixed: source was re-authenticating every request (DateTime math was incorrect)

### Removed
- remove SchedulingBooked.Query Patient property. It is not present on the corresponding redox model and was never used.

## [0.4.0] - 2020-09-04
### Added
- add email and phone to demographics
- add patient contacts

## [0.3.0] - 2020-08-27
### Added
- _body attribute containing raw response text on query results
- SchedulingBooked.Query

## [0.2.0] - 2020-08-16
### Added
- improve release process

### Changed
- fixed CHANGELOG url in gemspec

## [0.1.0] - 2020-08-14
### Added
- implement PatientSearch.Query

[0.1.0]: https://github.com/patient-discovery/redox-client/releases/tag/v0.1.0
[0.2.0]: https://github.com/patient-discovery/redox-client/releases/tag/v0.2.0
[0.3.0]: https://github.com/patient-discovery/redox-client/releases/tag/v0.3.0
[0.4.0]: https://github.com/patient-discovery/redox-client/releases/tag/v0.4.0
[0.5.0]: https://github.com/patient-discovery/redox-client/releases/tag/v0.5.0
[Unreleased]: https://github.com/patient-discovery/redox-client/compare/v0.5.0...HEAD
