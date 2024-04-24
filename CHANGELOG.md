# master

## Next

* Fix crash when mapping PostgreSQL enum to ruby variable in https://github.com/toptal/granite-form/pull/28

## v0.5.0

* Support for ruby 3.2 by @konalegi in https://github.com/toptal/granite-form/pull/22
* Fix deprecated #to_s method by @mpiask in https://github.com/toptal/granite-form/pull/24
* Support for Rails 7.1 by @ojab in https://github.com/toptal/granite-form/pull/25
* [BREAKING] Drop support for Rails < 6.0 by @ojab in https://github.com/toptal/granite-form/pull/25

## v0.4.0

* [BREAKING] Drop support for taking `model` as first argument in default/readonly/enum/normalize. This means that `default: -> (model) { model.other_field}` is no longer supported and should be replaced with `default: -> { other_field }`.
* Add support for evaluating `Symbol` for readonly/enum/normalize. If symbol is passed in one of those options, method with that name will be called when evaluating the value.
* [BREAKING] Remove `localized` attribute type.
* [BREAKING] Change the behavior of `default` and `normalize` for `collection` & `dictionary`. Instead of acting per element they will now act on the attribute as a whole.
  * E.g. `collection :numbers, default: [1, 2, 3]` will not set the default for the whole collection of `numbers` rather than each element in `numbers`.

## v0.3.0

- [BREAKING] Stop automatically saving `references_one`/`references_many` when applying changes.
- [BREAKING] Removed Lifecycle module. `embeds_many`/`embeds_one` objects can no longer be created/saved/updated/destroyed.
- [BREAKING] Due to changes above `accepts_nested_attributes_for` for `embeds_many`/`embeds_one` associations no longer marks objects for destruction but simply removes them, making changes instantly.
- Drop support for ruby 2.3 and rails 4.2

## v0.2.0

- Replace typecasters with proper type definitions.
  - Instead of `typecaster(type) { |value, _| ... }` you'll have to use `typecaster(type) { |value| ... }`.
  - Consequently you can access type definition in typecaster, e.g. `typecaster('Object') { |value| value if value.class < type }`, here `type` comes from type definition.

## v0.1.1

- Fixed represented error message copying when represented model uses symbols for `message`.

## v0.1.0

- Forked from ActiveData, see https://github.com/pyromaniac/active_data/blob/v1.2.0/CHANGELOG.md for changes before this
