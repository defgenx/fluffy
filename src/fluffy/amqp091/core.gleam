import gleam/dynamic.{Dynamic}
import gleam/map.{Map}
import gleam/option.{Option}
import gleam/erlang/atom.{Atom}
import gleam/erlang/charlist.{Charlist}

pub type Table =
  Map(String, Dynamic)

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

pub type QueueDeclare {
  QueueDeclare(
    ticket: Int,
    queue: String,
    passive: Bool,
    durable: Bool,
    exclusive: Bool,
    auto_delete: Bool,
    nowait: Bool,
    arguments: Table,
  )
}

pub type QueueDeclareOk {
  QueueDeclareOk(queue: String, message_count: Int, consumer_count: Int)
}

pub type QueueBind {
  QueueBind(
    ticket: Int,
    queue: String,
    exchange: String,
    routing_key: String,
    nowait: Bool,
    arguments: Table,
  )
}

pub type QueueBindOk {
  QueueBindOk
}

pub type QueueUnBind {
  QueueUnBind(
    ticket: Int,
    queue: String,
    exchange: String,
    routing_key: String,
    arguments: Table,
  )
}

pub type QueueUnBindOk {
  QueueUnBindOk
}

pub type QueueDelete {
  QueueDelete(
    ticket: Int,
    queue: String,
    if_unused: Bool,
    if_empty: Bool,
    nowait: Bool,
  )
}

pub type QueueDeleteOk {
  QueueDeleteOk(message_count: Int)
}

pub type QueuePurge {
  QueuePurge(ticket: Int, queue: String, nowait: Bool)
}

pub type QueuePurgeOk {
  QueuePurgeOk(message_count: Int)
}

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
    queue: String,
    passive: Bool,
    durable: Bool,
    exclusive: Bool,
    auto_delete: Bool,
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

pub type ExchangeUnbindOk {
  ExchangeUnbindOk
}

pub type AMQPMessage {
  AMQPMessage(props: Basic, payload: String)
}

pub type SSLOption {
  SSLOption(
    cacertfile: String,
    certfile: String,
    keyfile: String,
    depth: Int,
    verify: Atom,
    fail_if_no_peer_cert: Bool,
  )
}

pub type AMQPParamsNetwork {
  AMQPParamsNetwork(
    username: String,
    password: String,
    virtual_host: String,
    host: Charlist,
    port: Int,
    channel_max: Int,
    frame_max: Int,
    heartbeat: Int,
    connection_timeout: Int,
    ssl_options: Option(SSLOption),
    auth_mechanisms: List(AuthMechanism),
    client_properties: List(#(String, Atom, String)),
    socket_options: List(Dynamic),
  )
}

pub type AMQPParamsDirect {
  AMQPParamsDirect(
    username: String,
    password: String,
    virtual_host: String,
    node: Atom,
    adapter_info: Int,
    client_properties: List(#(String, Atom, String)),
  )
}

pub type AuthMechanism =
  fn(Dynamic, Dynamic, Dynamic) -> #(String, Dynamic)

pub external type Undefined
