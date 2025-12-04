#include "common.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
  if (argc < 2) {
    fprintf(stderr, "Usage: %s <input-file>\n", argv[0]);
    return -1;
  }

  return handle_file(argv[1], &handler);
}

uint64_t handler(char *buffer, int rstart_start, int rstart_end, int rend_start,
                 int rend_end) {
  int rstart_size = rstart_end - rstart_start;
  char *rstart = malloc(sizeof(char) * (rstart_size + 1));
  if (rstart != NULL) {
    char *rstart_ptr = &buffer[rstart_start];
    memcpy(rstart, rstart_ptr, rstart_size);
    rstart[rstart_size] = 0;
    printf("start = %s;", rstart);
    free(rstart);
  }

  int rend_size = rend_end - rend_start;
  char *rend = malloc(sizeof(char) * (rend_size + 1));
  if (rend != NULL) {
    char *rend_ptr = &buffer[rend_start];
    memcpy(rend, rend_ptr, rend_size);
    rend[rend_size] = 0;
    printf("end = %s\n", rend);
    free(rend);
  }

  return 0;
}
