#include <stdio.h>
#define NOB_IMPLEMENTATION
#include "nob.h"

void run() {
  printf("printing");
}

void main(int argc, char **argv) {
  run();
  NOB_GO_REBUILD_URSELF(argc, argv);
  Nob_Cmd cmd = {0};
  nob_cmd_append(&cmd, "cc", "-Wall", "-Wextra", "-o", "main", "testing.c");
  if (!nob_cmd_run_sync(cmd)) return 1;
  return 0;
}

