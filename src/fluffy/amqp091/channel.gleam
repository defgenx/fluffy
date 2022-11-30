import gleam/erlang/process.{Pid}
import gleam/erlang/atom.{Atom}
import gleam/dynamic.{Dynamic}
import gleam/option.{None, Option, Some}
import fluffy/amqp091/connection.{Connection}

type CustomConsumer =
  #(Atom, Dynamic)

pub type Channel {
  Channel(conn: Connection, pid: Pid, custom_consumer: Option(CustomConsumer))
}

pub fn open(
  conn: Connection,
  custom_consumer: Option(CustomConsumer),
) -> Result(Channel, any) {
  case custom_consumer {
    Some(cc) ->
      case do_open_with_custom_consumer(conn, cc) {
        Ok(pid) -> Ok(Channel(conn: conn, pid: pid, custom_consumer: Some(cc)))
        Error(e) -> Error(e)
      }
    None ->
      case do_open(conn) {
        Ok(pid) -> Ok(Channel(conn: conn, pid: pid, custom_consumer: None))
        Error(e) -> Error(e)
      }
  }
}

external fn do_open_with_custom_consumer(
  Connection,
  CustomConsumer,
) -> Result(Pid, any) =
  "amqp_connection" "open_channel"

external fn do_open(Connection) -> Result(Pid, any) =
  "amqp_connection" "open_channel"
