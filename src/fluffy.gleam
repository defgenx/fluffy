import gleam/io
import gleam/option.{None}
import fluffy/amqp091/connection
import fluffy/amqp091/channel
import fluffy/amqp091/core.{AMQPParamsNetwork}
import gleam/erlang/charlist
import fluffy/amqp091/amqp_auth_mechanisms

pub fn main() {
  assert Ok(c) =
    connection.open(
      AMQPParamsNetwork(
        username: "guest",
        password: "guest",
        host: charlist.from_string("localhost"),
        port: 5682,
        virtual_host: "/",
        channel_max: 0,
        frame_max: 0,
        heartbeat: 10,
        connection_timeout: 60000,
        ssl_options: None,
        auth_mechanisms: [
          amqp_auth_mechanisms.plain,
          amqp_auth_mechanisms.amqplain,
        ],
        client_properties: [],
        socket_options: [],
      ),
      "fluffy",
    )

  assert Ok(chan) = channel.open(c, None)

  io.debug(channel.close(chan))
  io.debug(connection.close(c))
}
