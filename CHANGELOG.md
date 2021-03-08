# Changelog
All notable changes to this project will be documented in this file.

## [1.0.0] - 2021-03-08
### Added
- Migrate to null safety
- Update minimum dart SDK version to 2.12.0
### Changed
- Change `RaisedButton` to `ElevationButton` in example

## [0.1.3] - 2021-03-04
### Fixed
- Fix deprecated call to `ancestorWidgetOfExactType` (method has been removed from Flutter 2.0) [#34](https://github.com/mobiten/flutter_staggered_animations/issues/34) [#29](https://github.com/mobiten/flutter_staggered_animations/issues/29)
- Fix call to `setState` after `dispose` in `AnimationLimiter` [#9](https://github.com/mobiten/flutter_staggered_animations/issues/9) [#15](https://github.com/mobiten/flutter_staggered_animations/issues/15) [#24](https://github.com/mobiten/flutter_staggered_animations/issues/24) [#31](https://github.com/mobiten/flutter_staggered_animations/issues/31)
### Added
- Add `curve` parameter for animations [#21](https://github.com/mobiten/flutter_staggered_animations/issues/21) [#22](https://github.com/mobiten/flutter_staggered_animations/issues/22)

## [0.1.2] - 2019-09-11
### Fixed
- [#1](https://github.com/mobiten/flutter_staggered_animations/issues/1) Do not forward animation after dispose
- Remove misleading usage of staggeredList instead of staggeredGrid in GridView sample

## [0.1.1] - 2019-09-05
### Added
- Logo in README

## [0.1.0] - 2019-09-04
### Added
- Example app to show the use of the library
- Static analysis configuration
### Fixed
- Fix all static analysis info and errors

## [0.0.1] - 2019-09-04
- Initial release



