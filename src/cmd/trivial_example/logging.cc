
#include "logging/core.h"

int main(int, char*[]) {
  eureka::logging::init();
  INFO("AAAA");
  return 0;
}
