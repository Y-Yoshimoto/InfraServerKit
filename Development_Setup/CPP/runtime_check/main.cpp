// Copyright 2025 y-yoshimoto
#include "add.hpp"
#include <cstdio>
#include <iostream>

// Hello world program
int main() {
  // ハローワールドを表示
  printf("Hello world!\n");
  // 足し算の結果を表示
  int a = 1;
  int b = 2;
  int c = add(a, b);
  printf("%d + %d = %d\n", a, b, c);
  return 0;
}
