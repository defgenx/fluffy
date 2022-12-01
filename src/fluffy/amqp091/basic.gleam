import fluffy/amqp091/core.{AMQPError, Table}
import gleam/erlang/atom.{Atom}
import gleam/erlang/process.{Pid}
import fluffy/amqp091/channel.{Channel}

pub type Basic {
  Basic(
    content_type: String,
    content_encoding: String,
    headers: Table,
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
  )
}

pub type BasicQos {
  BasicQos(prefetch_size: Int, prefetch_count: Int, global: Bool)
}

pub type BasicQosOk {
  BasicQosOk
}

pub type BasicGet {
  BasicGet(ticket: Int, queue: String, no_ack: Bool)
}

pub type BasicGetOk {
  BasicGetOk(
    delivery_tag: Int,
    redelivered: Bool,
    exchange: String,
    routing_key: String,
    message_count: Int,
  )
}

pub type BasicGetEmpty {
  BasicGetEmpty(cluster_id: String)
}

pub type BasicAck {
  BasicAck(delivery_tag: Int, multiple: Bool)
}

pub type BasicConsume {
  BasicConsume(
    ticket: Int,
    queue: String,
    consumer_tag: String,
    no_local: Bool,
    no_ack: Bool,
    exclusive: Bool,
    nowait: Bool,
    arguments: Table,
  )
}

pub type BasicConsumeOk {
  BasicConsumeOk(consumer_tag: String)
}

pub type BasicPublish {
  BasicPublish(
    ticket: Int,
    exchange: String,
    routing_key: String,
    mandatory: Bool,
    immediate: Bool,
  )
}

pub type BasicReturn {
  BasicReturn(
    reply_code: Int,
    reply_text: String,
    exchange: String,
    routing_key: String,
  )
}

pub type BasicCancel {
  BasicCancel(consumer_tag: String, nowait: Bool)
}

pub type BasicCancelOk {
  BasicCancelOk(consumer_tag: String)
}

pub type BasicDeliver {
  BasicDeliver(
    consumer_tag: String,
    delivery_tag: Int,
    redelivered: Bool,
    exchange: String,
    routing_key: String,
  )
}

pub type BasicReject {
  BasicReject(delivery_tag: String, requeue: Bool)
}

pub type BasicRecoverAsync {
  BasicRecoverAsync(requeue: Bool)
}

pub type BasicRecover {
  BasicRecover(requeue: Bool)
}

pub type BasicRecoverOk {
  BasicRecoverOk
}

pub type BasicNack {
  BasicNack(delivery_tag: Int, multiple: Bool, requeue: Bool)
}

pub type BasicCredit {
  BasicCredit(consumer_tag: String, credit: Int, drain: Int)
}

pub type BasicCreditOk {
  BasicCreditOk(available: Int)
}

pub type BasicCreditDrained {
  BasicCreditDrained(consumer_tag: String, credit_drained: Int)
}

pub type AMQPMessage {
  AMQPMessage(props: Basic, payload: String)
}

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
) -> Result(String, AMQPError) {
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
    Error(reason) -> Error(reason)
  }
}

external fn do_call(Pid, BasicPublish, AMQPMessage) -> Result(Atom, AMQPError) =
  "amqp_channel" "call"
