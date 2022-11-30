import gleam/erlang/process.{Pid}
import gleam/erlang.{Reference}
import gleam/option.{Option}
import gleam/map.{Map}
import fluffy/amqp091/core.{Undefined}

pub type Unassigned {
  Undefined
  Pid
}

pub type SelectiveConsumer {
  SelectiveConsumer(
    consumers: Map(String, Pid),
    unassigned: Unassigned,
    monitors: Map(Pid, #(Int, Reference)),
    default_consumer: Option(Pid),
    return_handler: Option(Pid),
  )
}
