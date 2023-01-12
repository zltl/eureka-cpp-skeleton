module;

#include <iostream>

export module my_app_1.foo;
namespace foo {
  export int FooFunc() {
    using namespace std;
    cout << "on module foo, call FooFunc()" << endl;
    return 0;
  }
}
