// Copyright 2025 y-yoshimoto
#include <gtest/gtest.h>
// テスト対象
#include "add.hpp"

// テスト実行コマンドサンプル
// GCC
// g++ add_test.cpp add.cpp -o test.out -g -pthread -lgtest_main -lgtest &&
// ./test.out && rm test.out Clang clang++ add_test.cpp add.cpp -o test.out -g
// -pthread -lgtest_main -lgtest && ./test.out && rm test.out

TEST(ABC, abc) {
  // 足し算の結果をテスト
  EXPECT_EQ(1, add(0, 1));
  EXPECT_EQ(13, add(10, 3));
}
