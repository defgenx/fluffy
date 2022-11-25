import gleam/erlang/atom.{Atom}
import gleam/io
import gleam/map.{Map}
import gleam/dynamic
import fluffy/logger/field.{Fields}
import fluffy/logger/arg.{Arg, Args}
import fluffy/logger.{Glog}

pub fn main() {
  logger.new()
  |> logger.add("wooxvd", "scvvd")
  |> logger.add_field(field.new("woo", "zoo"))
  |> logger.add_fields(Fields([field.new("foo", "bar"), field.new("bar", 123)]))
  |> logger.emergencyf(
    "nice one dude ~p ~p",
    Args([arg.new("ok"), arg.new("foo")]),
  )

  io.debug("foo")
}
