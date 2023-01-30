module;

#include "logging/wrap_spdlog.h"

export module eureka.logging;
namespace eureka {
namespace logging {

enum level_enum : int {
  trace = 0,
  debug,
  info,
  warn,
  err,
  critical,
  off,
  n_levels
};

  export void init() { __init(); }
}  // namespace logging
}  // namespace eureka
