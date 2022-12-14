# master

## Next

- [BREAKING] Stop automatically saving `references_one`/`references_many` when applying changes.

## v0.2.0

- Replace typecasters with proper type definitions.
  - Instead of `typecaster(type) { |value, _| ... }` you'll have to use `typecaster(type) { |value| ... }`.
  - Consequently you can access type definition in typecaster, e.g. `typecaster('Object') { |value| value if value.class < type }`, here `type` comes from type definition.

## v0.1.1

- Fixed represented error message copying when represented model uses symbols for `message`. 

## v0.1.0

- Forked from ActiveData, see https://github.com/pyromaniac/active_data/blob/v1.2.0/CHANGELOG.md for changes before this
