#pragma once

#include <fmt/core.h>

namespace eureka {
namespace logging {
void __init();

template <typename... Args>
inline void __log(const char *file, int line, const char *func, int level,
                  fmt::format_string<Args...> fmt, Args &&...) {
  (void)file;
  (void)line;
  (void)func;
  (void)level;
  (void)fmt;
  /*
  spdlog::default_logger_raw()->log(
      spdlog::source_loc{file, line, func},
      static_cast<spdlog::level::level_enum>(level), fmt,
      std::forward<Args>(args)...);
  */
}

void __rotate_log(const std::string &logger_name, const std::string &filename,
                  size_t max_file_size, size_t max_files);

void __set_level(int lv);

}  // namespace logging
}  // namespace eureka
