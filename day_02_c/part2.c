#include "common.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char** argv)
{
  if (argc < 2)
  {
    fprintf(stderr, "Usage: %s <input-file>\n", argv[0]);
    return -1;
  }

  return handle_file(argv[1], &handler);
}

int is_bad_id(char* buffer, int size, int buf_size)
{
  if (buf_size % size != 0)
    return 0;
  for (int i = 0; i < size; i++)
  {
    char cur = buffer[i];
    for (int x = i + size; x < buf_size; x += size)
    {
      if (cur != buffer[x])
      {
        return 0;
      }
    }
  }
  return 1;
}

uint64_t handler(char* buffer, int rstart_start, int rstart_end, int rend_start, int rend_end)
{
  uint64_t rstart_num = 0;
  uint64_t rend_num   = 0;

  int   rstart_size = rstart_end - rstart_start;
  char* rstart      = malloc(sizeof(char) * (rstart_size + 1));
  if (rstart != NULL)
  {
    char* rstart_ptr = &buffer[rstart_start];
    memcpy(rstart, rstart_ptr, rstart_size);
    rstart[rstart_size] = 0;
    rstart_num          = atol(rstart);
    free(rstart);
  }

  int   rend_size = rend_end - rend_start;
  char* rend      = malloc(sizeof(char) * (rend_size + 1));
  if (rend != NULL)
  {
    char* rend_ptr = &buffer[rend_start];
    memcpy(rend, rend_ptr, rend_size);
    rend[rend_size] = 0;
    rend_num        = atol(rend);
    free(rend);
  }

  uint64_t sum = 0;
  char*    buf = malloc(sizeof(char) * (rend_size + 1));
  if (buf == NULL)
  {
    fprintf(stderr, "Failed to check range %s-%s\n", rstart, rend);
    return 0;
  }
  for (uint64_t i = rstart_num; i <= rend_num; i++)
  {
    sprintf(buf, "%ld", i);
    int len = strlen(buf);
    for (int j = 1; j <= len / 2; j++)
    {
      if (is_bad_id(buf, j, len))
      {
        sum += i;
        break;
      }
    }
  }
  free(buf);

  return sum;
}
