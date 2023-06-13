# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.4.3 - 2023-06-13
### Changed
- Updated dependencies
- Removed older Ruby versions from CI

## 0.4.2 - 2023-04-14
### Changed
- Remove ruby 2 support

## 0.4.1 - 2023-03-14
### Fixed
- Switched from using `StringIO#chars` (deprecated, removed in ruby 3) to `StringIO#each_char`

## 0.4.0 - 2022-12-05
### Changed
- Update `net-sftp` to `4.0.0`
- Update `net-ssh` to `7.0.1`

## 0.3.10 - 2022-11-08
### Changed
- Add `download_with_handler`

## 0.3.9 - 2022-04-04
### Changed
- Updated dependencies

## 0.3.8 - 2022-01-11
### Changed
- Update to ws-gem_publisher 4
- Add necessary dev dependencies

## 0.3.7 - 2021-12-20
### Changed
- Updated dependencies

## 0.3.6 - 2021-09-29
### Changed
- Updated dependencies

## 0.3.5 - 2021-08-30
### Changed
- Updated dependencies

## 0.3.4 - 2021-07-28
### Changed
- Updated dependencies

## 0.3.3 - 2021-07-12
### Changed
- Updated dependencies

## 0.3.2 - 2021-07-12
### Changed
- Updated dependencies

## 0.3.1 - 2021-04-16
### Changed
- Updated dependencies
- Migrate CI from CircleCI to GitHub Actions
- Change default GitHub branch to `main`

## 0.3.0 - 2021-04-23
### Added
- Add ability to specify additional Net::SFTP options, such as public/private key.

## 0.2.1 - 2021-03-11
### Changed
- Upgrade to ruby 2.7.2

## 0.2.0 - 2019-05-01
### Added
- Send coverage report to coveralls.io

## 0.1.0 - 2019-01-09
### Added
- Publish gem to our private server
