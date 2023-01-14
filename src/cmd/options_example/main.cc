#include <fmt/printf.h>
#include <fmt/ranges.h>

#include <boost/program_options.hpp>
#include <string>
#include <vector>

#include "boost/program_options/options_description.hpp"
#include "boost/program_options/parsers.hpp"
#include "boost/program_options/positional_options.hpp"
#include "boost/program_options/variables_map.hpp"

using std::string;
using std::vector;

namespace po = boost::program_options;

int main(int argc, const char** argv) {
  int opt;
  po::options_description desc("Allowed options");

  // ./target/debug/options_example --optimization 4 -I foo -I another/path \
  //                                --include-path third/include/path a.cpp b.cpp
  desc.add_options()                                              //
      ("help", "produce help message")                            //
      ("compression", po::value<int>(), "set compression level")  //
      ("optimization", po::value<int>(&opt)->default_value(0),
       "optimiation level")                                            //
      ("include-path,I", po::value<vector<string>>(), "include path")  //
      ("input-file", po::value<vector<string>>(), "input file")        //
      ;

  po::positional_options_description p;
  p.add("input-file", -1);

  po::variables_map vm;
  po::store(
      po::command_line_parser(argc, argv).options(desc).positional(p).run(),
      vm);
  po::notify(vm);

  if (vm.count("help")) {
    std::stringstream s;
    s << desc;
    fmt::print("{}", s.str());
    return 1;
  }

  if (vm.count("include-path")) {
    fmt::print("Include paths are: {}\n",
               vm["include-path"].as<vector<string>>());
  }

  if (vm.count("input-file")) {
    fmt::print("Include files are: {}\n",
               vm["input-file"].as<vector<string>>());
  }

  fmt::print("Optimization level is {}\n", opt);

  if (vm.count("compression")) {
    fmt::print("Compression level was set to {}\n",
               vm["compression"].as<int>());
  } else {
    fmt::print("Compression level was not set.\n");
  }

  return 0;
}
