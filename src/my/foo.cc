module;

#include <fmt/printf.h>

#include <iostream>

export module my.foo;
namespace foo {
export int FooFunc() {
  fmt::print("Don't {}\n", "panic");
  using namespace std;
  cout << "on module foo, call FooFunc()" << endl;
  return 0;
}
}  // namespace foo
