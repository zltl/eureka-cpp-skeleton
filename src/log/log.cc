module;

#include <iostream>
#include <memory>
#include <string>
#include <string_view>

#include "log/boost_wrap.h"

export module eureka.log;

namespace eureka {
namespace log {

export class Config : public std::enable_shared_from_this<Config> {
 public:
  [[nodiscard]] static std::shared_ptr<Config> create() {
    static auto instance = std::shared_ptr<Config>(new Config());
    return instance;
  }

  using ConfigT = ::std::shared_ptr<Config>;
  ConfigT set_filename(const ::std::string_view& filename) {
    this->filename_ = filename;
    return shared_from_this();
  }
  ConfigT set_file_rotate_size(size_t size) {
    this->file_rotate_size_ = size;
    return shared_from_this();
  }
  ConfigT set_dir(const ::std::string_view& dir) {
    this->dir_ = dir;
    return shared_from_this();
  }
  ConfigT set_dir_max_size(size_t size) {
    this->dir_max_size_ = size;
    return shared_from_this();
  }
  ConfigT set_min_free_space(size_t size) {
    this->min_free_space_ = size;
    return shared_from_this();
  }

  void apply() {
    _boost_log_conf_func(filename_, file_rotate_size_, dir_, dir_max_size_,
                         min_free_space_);
  }

 private:
  Config() = default;

  ::std::string filename_ = "%Y%m%dT%H_%5N.log";
  size_t file_rotate_size_ = 50UL * 1024 * 1024;
  ::std::string dir_ = "logs";
  size_t dir_max_size_ = 100UL * 50 * 1024 * 1044;
  size_t min_free_space_ = 100UL * 1024 * 102;
};

export std::shared_ptr<Config> conf() {
  return Config::create();
}

}  // namespace log
}  // namespace eureka
