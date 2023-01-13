module;

#include <iostream>
#include <fmt/printf.h>

export module my.foo;
namespace foo {
  export int FooFunc() {
    fmt::print("Don't {}\n", "panic");
    using namespace std;
    cout << "on module foo, call FooFunc()" << endl;
    return 0;
  }
}
