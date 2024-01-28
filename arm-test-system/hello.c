#include <stdio.h>
int main(void) {
#ifdef __aarch64__
  printf("Hello, ARM64 world!\n");
#elif defined(__arm__)
  printf("Hello, ARM world!\n");
#else
  printf("Hello, world!\n");
#endif
  return 0;
}