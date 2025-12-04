#include "common.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define BUFFER_SIZE 1024

int handle_file(char *file_path,
                uint64_t (*callback)(char *, int, int, int, int)) {

  FILE *file = fopen(file_path, "r");
  if (file == NULL) {
    fprintf(stderr, "Failed to open file at '%s'\n", file_path);
    return 1;
  }

  uint64_t result = 0;

  int should_resize = 1;
  while (should_resize) {
    char buffer[BUFFER_SIZE] = {0};
    unsigned long bytes_read = fread(buffer, sizeof(char), BUFFER_SIZE, file);
    if (bytes_read == 0) {
      break;
    }
    if (bytes_read <= 2) {
      fprintf(stderr, "Read too little to be a range\n");
      fclose(file);
      return 2;
    }
    if (bytes_read < BUFFER_SIZE) {
      should_resize = 0;
    }

    int rstart_start = 0;
    int rstart_end = 0;
    int rend_start = 0;
    int rend_end = 0;

    for (int i = 0; i < BUFFER_SIZE; i++) {
      if (buffer[i] == '\n') {
        rend_end = i;
        result +=
            callback(buffer, rstart_start, rstart_end, rend_start, rend_end);
        should_resize = 0;
        break;
      }
      if (buffer[i] == '-') {
        rstart_end = i;
        rend_start = i + 1;
      }
      if (buffer[i] == ',') {
        rend_end = i;
        result +=
            callback(buffer, rstart_start, rstart_end, rend_start, rend_end);
        rstart_start = i + 1;
      }
      if (buffer[i] == 0) {
        if (!should_resize) {
          rend_end = i;
          result +=
              callback(buffer, rstart_start, rstart_end, rend_start, rend_end);
        }
        break;
      }
    }
    if (should_resize) {
      if (fseek(file, rstart_start - BUFFER_SIZE, SEEK_CUR)) {
        fprintf(stderr, "Failed to realloc buffer\n");
        fclose(file);
        return 3;
      }
    }
  }

  printf("Result = %ld\n", result);
  fclose(file);
  return 0;
}
