import gleam/erlang/process.{Pid}
import fluffy/amqp091/core.{AMQPParamsNetwork}

pub type Connection {
  Connection(pid: Pid)
}

pub fn open(params: AMQPParamsNetwork, name: String) -> Result(Connection, any) {
  do_open(params, name)
}

external fn do_open(AMQPParamsNetwork, String) -> Result(Connection, any) =
  "amqp_connection" "start"
