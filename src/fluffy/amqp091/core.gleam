import gleam/dynamic.{Dynamic}
import gleam/map.{Map}
import gleam/option.{Option}
import gleam/erlang/atom.{Atom}
import gleam/erlang/charlist.{Charlist}

pub type Table =
  Map(String, Dynamic)

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

pub external type Blocked

pub external type Closing

pub type AMQPError {
  Blocked
  Closing
}
