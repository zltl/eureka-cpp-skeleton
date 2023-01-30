#include <fmt/format.h>
#include <spdlog/sinks/rotating_file_sink.h>
#include <spdlog/spdlog.h>

#include <memory>
#include <string>

#include <fmt/format.h>
#include <fmt/core.h>
#include <spdlog/common.h>
#include <spdlog/logger.h>

namespace eureka {
namespace logging {

static void __use_default_pattern() {
  spdlog::set_pattern("[%Y-%m-%d %H:%M:%S.%f%z] [%^%l%$] [%P/%t] %v [%g:%#/%!]");
}


void __init() {
  __use_default_pattern();
}

void __rotate_log(const std::string &logger_name,
                  const std::string &filename, size_t max_file_size,
                  size_t max_files) {
  auto lg = spdlog::rotating_logger_mt(logger_name, filename, max_file_size,
                                       max_files);
  spdlog::set_default_logger(lg);
  __use_default_pattern();
}

void __set_level(int lv) {
  spdlog::set_level(static_cast<spdlog::level::level_enum>(lv));
}

}  // namespace logging

}  // namespace eureka
