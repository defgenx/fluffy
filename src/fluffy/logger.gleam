import gleam/erlang/atom.{Atom}
import gleam/io
import gleam/map.{Map}
import gleam/list
import gleam/dynamic.{Dynamic}
import fluffy/logger/field.{Field}
import fluffy/logger/level.{
  Alert, Critical, Debug, Emergency, Error, Info, Level, Notice, Warning,
}

pub opaque type Glog {
  Glog(fields: Map(String, Dynamic))
}

pub fn new() -> Glog {
  Glog(fields: map.new())
}

pub fn with_field(log: Glog, f: Field) -> Glog {
  Glog(
    log.fields
    |> map.insert(field.key(f), field.value(f)),
  )
}

pub fn with_fields(log: Glog, fields: List(Field)) -> Glog {
  Glog(fields: map.merge(
    log.fields,
    map.from_list(
      fields
      |> list.map(fn(f) { #(field.key(f), field.value(f)) }),
    ),
  ))
}

pub fn emergency(log: Glog, value: String) -> Glog {
  log_string_with_fields(Emergency, value, log.fields)

  Glog(fields: map.new())
}

pub fn emergencyf(log: Glog, string: String, values: List(Dynamic)) -> Glog {
  log_string_with_list_map(Warning, string, values, log.fields)

  Glog(fields: map.new())
}

//pub fn alert(log: Glog, any) -> Nil {
//  log(Alert, any)
//}
//
//pub fn critical(log: Glog, any) -> Nil {
//  log(Critical, any)
//}
//
//pub fn error(log: Glog, any) -> Nil {
//  log(Error, any)
//}
//
//pub fn warning(log: Glog, any) -> Nil {
//  log(Warning, any)
//}
//
//pub fn notice(log: Glog, any) -> Nil {
//  log(Notice, any)
//}
//
//pub fn info(log: Glog, any) -> Nil {
//  log(Info, any)
//}
//
//pub fn debug(log: Glog, any) -> Nil {
//  log(Debug, any)
//}

pub external fn log_string_with_fields(
  Level,
  String,
  Map(String, Dynamic),
) -> Nil =
  "logger" "log"

pub external fn log_string_with_list_map(
  Level,
  String,
  List(Dynamic),
  Map(String, Dynamic),
) -> Nil =
  "logger" "log"

pub external fn set_primary_config(Map(Atom, Dynamic)) -> Nil =
  "logger" "set_primary_config"
