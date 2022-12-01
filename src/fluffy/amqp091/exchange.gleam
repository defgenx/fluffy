import fluffy/amqp091/channel.{Channel}
import fluffy/amqp091/core.{AMQPError, Blocked, Closing, Table}
import gleam/erlang/atom.{Atom}
import gleam/erlang/process.{Pid}

pub type ExchangeBind {
  ExchangeBind(
    ticket: Int,
    destination: String,
    source: String,
    routing_key: String,
    nowait: Bool,
    arguments: Table,
  )
}

pub type ExchangeBindOk {
  ExchangeBindOk
}

pub type ExchangeDelete {
  ExchangeDelete(
    ticket: Int,
    queue: String,
    if_unused: Bool,
    if_empty: Bool,
    nowait: Bool,
  )
}

pub type ExchangeDeleteOk {
  ExchangeDeleteOk
}

pub type ExchangeDeclare {
  ExchangeDeclare(
    ticket: Int,
    typ: String,
    passive: Bool,
    durable: Bool,
    auto_delete: Bool,
    internal: Bool,
    nowait: Bool,
    arguments: Table,
  )
}

pub type ExchangeDeclareOk {
  ExchangeDeclareOk
}

pub type ExchangeUnbind {
  ExchangeUnbind(
    ticket: Int,
    destination: String,
    source: String,
    routing_key: String,
    nowait: Bool,
    arguments: Table,
  )
}

pub external type ExchangeUnbindOk

pub fn declare(
  channel: Channel,
  exchange_declare: ExchangeDeclare,
) -> Result(ExchangeDeclareOk, AMQPError) {
  let atom_ok = atom.create_from_string("ok")
  case #(exchange_declare.nowait, do_call(channel.pid, exchange_declare)) {
    #(_, ExchangeDeclareOk) -> Ok(ExchangeDeclareOk)
    #(_, error) -> Error(error)
  }
}

external fn do_call(Pid, method) -> struct_or_atom =
  "amqp_channel" "call"
