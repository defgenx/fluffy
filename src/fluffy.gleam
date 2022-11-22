// todo: we are going to use external to make things easier but this must be moved to custom type instead...
external type Basic(
  content_type,
  content_encoding,
  headers,
  delivery_mode,
  priority,
  correlation_id,
  reply_to,
  expiration,
  message_id,
  timestamp,
  btype,
  user_id,
  app_id,
  cluster_id,
)

external type BasicGet(ticket, queue, no_ack)

external type BasicGetOk

external type BasicEmpty(cluster_id)

external type BasicAck(delivery_tag, multiple)

external type BasicConsume(
  ticket,
  queue,
  consumer_tag,
  no_local,
  no_ack,
  exclusive,
  nowait,
  arguments,
)

external type BasicConsumeOk

external type BasicPublish(ticket, exchange, routing_key, mandatory, immediate)

external type BasicReturn(reply_code, reply_text, exchange, routing_key)

external type BasicCancel(consumer_tag, nowait)

external type BasicCancelOk

external type BasicDeliver(
  consumer_tag,
  delivery_tag,
  redelivered,
  exchange,
  routing_key,
)

external type BasicReject(delivery_tag, requeue)

external type BasicRecover(requeue)

external type BasicRecoverOk

external type BasicDeclareOk

external type BasicQos(prefetch_size, prefetch_count, global)

external type BasicQosOk

external type BasicNack(delivery_tag, multiple, requeue)

external type BasicCreditDrained(consumer_tag, credit_drained)

external type Queue

external type QueueDeclareOk(queue, message_count, consumer_count)

external type QueueBind(ticket, queue, exchange, routing_key, nowait, arguments)

external type QueueBindOk

external type QueueUnBind(ticket, queue, exchange, routing_key, arguments)

external type QueueUnBindOk

external type QueueDelete(ticket, queue, if_unused, if_empty, nowait)

external type QueueDeleteOk

external type QueuePurge(ticket, queue, nowait)

external type QueuePurgeOk

external type Exchange

external type ExchangeDelete

external type ExchangeDeleteOk

external type ExchangeBindOk

external type ExchangeUnbind

external type ExchangeUnbindOk
