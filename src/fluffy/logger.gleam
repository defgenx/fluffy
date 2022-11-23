import gleam/erlang/atom.{Atom}
import fluffy/logger/level.{
  Alert, Critical, Debug, Emergency, Error, Info, Level, Notice, Warning,
}

pub type Report {
  Atom
  Term
}

pub type Metadata {
  Map(Atom, Term)
}

// A CharData is a charlist() | unicode_binary() in Erlang
pub external type Chardata

// A Term is an `any` type in Erlang
pub external type Term

pub type Args {
  List(Term)
}

pub type MetadataOrArgs {
  Metadata
  Args
}

pub external type FunOrFormat

pub type StringOrReport {
  String
  Report
}

pub type FunOrFormatOrStringOrReport {
  FunOrFormat
  StringOrReport
}

pub fn emergency(a) -> Nil {
  log(Emergency, a)
}

pub fn emergency2(a, b) -> Nil {
  log2(Emergency, a, b)
}

pub fn emergency3(a, b, c) -> Nil {
  log3(Emergency, a, b, c)
}

pub fn alert(a) -> Nil {
  log(Alert, a)
}

pub fn alert2(a, b) -> Nil {
  log2(Alert, a, b)
}

pub fn alert3(a, b, c) -> Nil {
  log3(Alert, a, b, c)
}

pub fn critical(a) -> Nil {
  log(Critical, a)
}

pub fn critical2(a, b) -> Nil {
  log2(Critical, a, b)
}

pub fn critical3(a, b, c) -> Nil {
  log3(Critical, a, b, c)
}

pub fn error(a) -> Nil {
  log(Error, a)
}

pub fn error2(a, b) -> Nil {
  log2(Error, a, b)
}

pub fn error3(a, b, c) -> Nil {
  log3(Error, a, b, c)
}

pub fn warning(a) -> Nil {
  log(Warning, a)
}

pub fn warning2(a, b) -> Nil {
  log2(Warning, a, b)
}

pub fn warning3(a, b, c) -> Nil {
  log3(Warning, a, b, c)
}

pub fn notice(a) -> Nil {
  log(Notice, a)
}

pub fn notice2(a, b) -> Nil {
  log2(Notice, a, b)
}

pub fn notice3(a, b, c) -> Nil {
  log3(Notice, a, b, c)
}

pub fn info(a) -> Nil {
  log(Info, a)
}

pub fn info2(a, b) -> Nil {
  log2(Info, a, b)
}

pub fn info3(a, b, c) -> Nil {
  log3(Info, a, b, c)
}

pub fn debug(a) -> Nil {
  log(Debug, a)
}

pub fn debug2(a, b) -> Nil {
  log2(Debug, a, b)
}

pub fn debug3(a, b, c) -> Nil {
  log3(Debug, a, b, c)
}

pub external fn log(Level, String) -> Nil =
  "logger" "log"

pub external fn log_report(Level, Report) -> Nil =
  "logger" "log"

pub external fn log2(Level, StringOrReport, MetadataOrArgs) -> Nil =
  "logger" "log"

pub external fn log3(Level, FunOrFormat, Args, Metadata) -> Nil =
  "logger" "log"

pub external fn set_primary_config(Atom, Atom) -> Nil =
  "logger" "set_primary_config"
