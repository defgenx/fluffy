import gleam/io
import fluffy/logger.{StringOrReport}

pub fn main() {
  logger.critical("foo")
  io.debug("foo")
}
