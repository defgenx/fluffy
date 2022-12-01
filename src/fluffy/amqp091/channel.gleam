import gleam/erlang/process.{Pid}
import gleam/erlang/atom.{Atom}
import gleam/dynamic.{Dynamic}
import gleam/option.{None, Option, Some}
import fluffy/amqp091/connection.{Connection}
import fluffy/amqp091/core.{Closing}

/// Optional values for consumer.
type CustomConsumer =
  #(Atom, Dynamic)

/// Channel structure
pub type Channel {
  Channel(conn: Connection, pid: Pid, custom_consumer: Option(CustomConsumer))
}

/// Opens a new Channel in a previously opened Connection.
///
/// Allows optionally to pass a `t:custom_consumer/0` to start a custom consumer
/// implementation. The consumer must implement the `:amqp_gen_consumer` behavior
/// from `:amqp_client`. See `:amqp_connection.open_channel/2` for more details
/// and `AMQP.DirectConsumer` for an example of a custom consumer.
pub fn open(
  conn: Connection,
  custom_consumer: Option(CustomConsumer),
) -> Result(Channel, any) {
  case custom_consumer {
    Some(cc) ->
      case do_open_with_custom_consumer(conn.pid, cc) {
        Ok(pid) -> Ok(Channel(conn: conn, pid: pid, custom_consumer: Some(cc)))
        Error(e) -> Error(e)
      }
    None ->
      case do_open(conn.pid) {
        Ok(pid) -> Ok(Channel(conn: conn, pid: pid, custom_consumer: None))
        Error(e) -> Error(e)
      }
  }
}

/// Close a channel
pub fn close(channel: Channel) -> Result(Nil, Closing) {
  do_close(channel.pid)
}

external fn do_open_with_custom_consumer(
  Pid,
  CustomConsumer,
) -> Result(Pid, any) =
  "amqp_connection" "open_channel"

external fn do_open(Pid) -> Result(Pid, any) =
  "amqp_connection" "open_channel"

external fn do_close(Pid) -> Result(Nil, Closing) =
  "amqp_channel" "close"
