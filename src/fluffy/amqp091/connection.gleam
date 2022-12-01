import gleam/erlang/process.{Pid}
import fluffy/amqp091/core.{AMQPError, AMQPParamsNetwork}
import gleam/erlang/atom.{Atom}
import gleam/dynamic.{Dynamic}

/// Channel structure
pub type Connection {
  Connection(pid: Pid)
}

/// Opens an new Connection to an AMQP broker
///
/// The connections created by this module are supervised under  amqp_client's
/// supervision tree.  Please note that connections do not get restarted
/// automatically by the supervision tree in case of a failure. If you need
/// robust connections and channels, use monitors on the returned connection PID
pub fn open(params: AMQPParamsNetwork, name: String) -> Result(Connection, any) {
  case do_open(params, name) {
    Ok(pid) -> Ok(Connection(pid: pid))
    Error(e) -> Error(e)
  }
}

/// Close a channel
pub fn close(conn: Connection) -> Result(Nil, AMQPError) {
  do_close(conn.pid)
}

external fn do_open(AMQPParamsNetwork, String) -> Result(Pid, any) =
  "amqp_connection" "start"

external fn do_close(Pid) -> Result(Nil, AMQPError) =
  "amqp_connection" "close"
