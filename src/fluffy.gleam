import gleam/erlang/atom.{Atom}
import gleam/io
import gleam/map.{Map}
import gleam/dynamic
import fluffy/logger/field
import fluffy/logger.{Glog}

pub fn main() {
  logger.new()
  |> logger.with_field(field.new("woo", "zoo"))
  |> logger.with_fields([field.new("foo", "bar"), field.new("bar", 123)])
  |> logger.emergency("tpt")

  io.debug("foo")
}
