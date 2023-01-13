module;

#include <boost/chrono.hpp>
#include <cmath>
#include <iostream>

export module my.boost;
namespace my {
namespace xboost {
export void BoostExample() {
  boost::chrono::system_clock::time_point start =
      boost::chrono::system_clock::now();

  for (long i = 0; i < 10000000; ++i) std::sqrt(123.456L);  // burn some time

  boost::chrono::duration<double> sec =
      boost::chrono::system_clock::now() - start;
  std::cout << "took " << sec.count() << " seconds\n";
}
}  // namespace boost
}  // namespace my