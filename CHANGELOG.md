# master

## Next
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
