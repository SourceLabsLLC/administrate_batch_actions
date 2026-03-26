# Changelog

All notable changes to this project will be documented in this file.

## [0.4.0] - 2026-03-26

### Added
- Support for Administrate 1.0.0

## [0.3.4] - 2023-01-10

### Security
- Bump nokogiri from 1.13.9 to 1.13.10

## [0.3.3] - 2022-10-18

### Security
- Bump rails-html-sanitizer from 1.3.0 to 1.4.3
- Bump rack from 2.2.3 to 2.2.4

## [0.3.2] - 2022-10-17

### Fixed
- Initialize the script on page load
- Reset checkbox status after clicking browser back button

## [0.3.1] - 2022-10-14

### Changed
- Toggle action buttons based on selections

## [0.3.0] - 2022-10-14

### Changed
- Disable batch action buttons when no rows are selected

## [0.2.0] - 2022-10-13

### Changed
- Additional `html_options` support in the helper
- Gem renamed to `administrate_batch_actions`

## [0.1.0] - 2022-10-12

### Added
- Initial release
- Partials and helpers to render batch action buttons and checkboxes
- JavaScript for managing checkbox selection state
- Router to automatically load batch action paths
- Asset precompilation support
