module;

#include <iostream>

export module foo;
namespace foo {
  export int FooFunc() {
    using namespace std;
    cout << "on module foo, call FooFunc()" << endl;
    return 0;
  }
}
