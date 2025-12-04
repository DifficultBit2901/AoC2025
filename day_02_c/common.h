#ifndef COMMON_H
#define COMMON_H
#include <stdint.h>

uint64_t handler(char *buffer, int rstart_start, int rstart_end, int rend_start,
                 int rend_end);

int handle_file(char *file_path,
                uint64_t (*callback)(char *, int, int, int, int));
#endif // !COMMON_H
