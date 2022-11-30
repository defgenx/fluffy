import gleam/dynamic.{Dynamic}

pub external fn plain(Dynamic, Dynamic, Dynamic) -> #(String, Dynamic) =
  "amqp_auth_mechanisms" "plain"

pub external fn amqplain(Dynamic, Dynamic, Dynamic) -> #(String, Dynamic) =
  "amqp_auth_mechanisms" "amqplain"
