#include <unistd.h>

int psleep (int duration) {
  sleep(duration);
  return 1;
}
