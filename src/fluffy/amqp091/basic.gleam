import fluffy/amqp091/core.{AMQPMessage, Basic, BasicPublish, Table}
import gleam/erlang/atom.{Atom}
import gleam/erlang/process.{Pid}
import fluffy/amqp091/channel.{Channel}

pub type Publishing {
  Publishing(
    headers: Table,
    content_type: String,
    content_encoding: String,
    delivery_mode: Int,
    priority: Int,
    correlation_id: String,
    reply_to: String,
    expiration: String,
    message_id: String,
    timestamp: Int,
    typ: String,
    user_id: String,
    app_id: String,
    cluster_id: String,
    payload: String,
  )
}

/// Publishes a message to an Exchange.
///
/// This method publishes a message to a specific exchange. The message will be
/// routed to queues as defined by the exchange configuration and distributed to
/// any subscribers.
/// The parameter `exchange` specifies the name of the exchange to publish to. If
/// set to empty string, it publishes to the default exchange.
/// The `routing_key` parameter specifies the routing key for the message.
/// The `payload` parameter specifies the message content as a String.
fn publish(
  channel: Channel,
  exchange: String,
  routing_key: String,
  mandatory: Bool,
  immediate: Bool,
  message: Publishing,
) -> Result(String, String) {
  let basic_publish =
    BasicPublish(
      ticket: 0,
      exchange: exchange,
      routing_key: routing_key,
      mandatory: mandatory,
      immediate: immediate,
    )
  let basic =
    Basic(
      headers: message.headers,
      content_type: message.content_type,
      content_encoding: message.content_encoding,
      delivery_mode: message.delivery_mode,
      priority: message.priority,
      correlation_id: message.correlation_id,
      reply_to: message.reply_to,
      expiration: message.expiration,
      message_id: message.message_id,
      timestamp: message.timestamp,
      typ: message.typ,
      user_id: message.user_id,
      app_id: message.app_id,
      cluster_id: message.cluster_id,
    )

  case
    do_call(
      channel.pid,
      basic_publish,
      AMQPMessage(props: basic, payload: message.payload),
    )
  {
    Ok(ok) -> Ok(atom.to_string(ok))
    Error(reason) -> Error(atom.to_string(reason))
  }
}

external fn do_call(Pid, BasicPublish, AMQPMessage) -> Result(Atom, Atom) =
  "amqp_channel" "call"
