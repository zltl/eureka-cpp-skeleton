#include "log/boost_wrap.h"

#include <boost/date_time/posix_time/posix_time.hpp>
#include <boost/log/attributes.hpp>
#include <boost/log/common.hpp>
#include <boost/log/core.hpp>
#include <boost/log/expressions.hpp>
#include <boost/log/sinks/sync_frontend.hpp>
#include <boost/log/sinks/text_file_backend.hpp>
#include <boost/log/sinks/text_ostream_backend.hpp>
#include <boost/log/sources/logger.hpp>
#include <boost/log/sources/record_ostream.hpp>
#include <boost/log/sources/severity_logger.hpp>
#include <boost/log/support/date_time.hpp>
#include <boost/log/trivial.hpp>
#include <boost/log/utility/setup/common_attributes.hpp>
#include <boost/smart_ptr/make_shared_object.hpp>
#include <boost/smart_ptr/shared_ptr.hpp>
#include <chrono>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>

namespace logging = boost::log;
namespace attrs = boost::log::attributes;
namespace src = boost::log::sources;
namespace sinks = boost::log::sinks;
namespace expr = boost::log::expressions;
namespace keywords = boost::log::keywords;
using boost::log::trivial::severity_level;

using boost::shared_ptr;

namespace eureka {
namespace log {

int _boost_log_conf_func(const ::std::string& filename, size_t file_rotate_size,
                         const ::std::string& dir, size_t dir_max_size,
                         size_t min_free_space) {
  // Create a text file sink
  typedef sinks::synchronous_sink<sinks::text_file_backend> file_sink;
  shared_ptr<file_sink> sink(new file_sink(
      keywords::file_name = filename,  // file name pattern
      keywords::rotation_size =
          file_rotate_size  // rotation size, in characters
      ));

  // Set up where the rotated files will be stored
  sink->locked_backend()->set_file_collector(sinks::file::make_collector(
      keywords::target = dir,  // where to store rotated files
      keywords::max_size =
          dir_max_size,  // maximum total size of the stored files, in bytes
      keywords::min_free_space =
          min_free_space  // minimum free space on the drive, in bytes
      ));

  // Upon restart, scan the target directory for files matching the file_name
  // pattern
  sink->locked_backend()->scan_for_files();

  std::string zstr(std::chrono::current_zone()->name());

  sink->set_formatter(
      expr::format(std::string("%1%: [%2%(") + zstr + ")] - %3%") %
      expr::attr<unsigned int>("RecordID") %
      expr::format_date_time<boost::posix_time::ptime>(
          "TimeStamp", "%Y-%m-%dT%H:%M:%S.%f%q") %
      expr::smessage);

  // Add it to the core
  logging::core::get()->add_sink(sink);

  // Add some attributes too
  logging::core::get()->add_global_attribute("TimeStamp", attrs::local_clock());
  logging::core::get()->add_global_attribute("RecordID",
                                             attrs::counter<unsigned int>());

  logging::add_common_attributes();

  // Do some logging
  src::severity_logger<severity_level> lg;
  BOOST_LOG_SEV(lg, severity_level::info) << "Some log record";

  return 0;
}

}  // namespace log
}  // namespace eureka
