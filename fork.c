#include <sys/stat.h>
#include <unistd.h>
#include <wait.h>
#include <stdio.h>

#define PAGESIZE 4096

int main() {
  int v = 5;

  if (fork() == 0) {
    v = 80;
  } else {
    wait(NULL);
  }

  printf("Not shared. %d \n", v);
}
