module;

#include <format>

#include <iostream>

export module my.foo;
namespace foo {
export int FooFunc() {
  using namespace std;
  cout << format("Don't {}\n", "panic")<< endl;
  cout << "on module foo, call FooFunc()" << endl;
  return 0;
}
}  // namespace foo
