import gleam/dynamic.{Dynamic}

pub opaque type Field {
  Field(key: String, value: Dynamic)
}

pub fn key(field: Field) -> String {
  field.key
}

pub fn value(field: Field) -> Dynamic {
  field.value
}

pub fn new(key: String, value: a) -> Field {
  Field(key, dynamic.from(value))
}
