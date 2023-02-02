#pragma once

#include <string>

namespace eureka {
namespace log {

int _boost_log_conf_func(const ::std::string& filename, size_t file_rotate_size,
                         const ::std::string& dir, size_t dir_max_size,
                         size_t min_free_space);

}  // namespace log
}  // namespace eureka
