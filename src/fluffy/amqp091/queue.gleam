import fluffy/amqp091/core.{Table}

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
