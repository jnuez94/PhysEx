#include <time.h>
#include <stdio.h>

clock_t st, end;
double total;
int i =0;

int main () {
  st = clock();
  printf("starting of the program, start = %ld\n", st);

  for(i=0; i < 10000000; i++) {}

  end = clock();
  printf("loop has ended, end = %ld\n", end);

  total= (double)(end - st) / CLOCKS_PER_SEC;
  printf("CPU time: %f\n", total);
}

// gcc -o pclock pclock.c
// clang -S -emit-llvm pclock.c
