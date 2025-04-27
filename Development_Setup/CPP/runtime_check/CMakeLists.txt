# Minimum CMake version required
cmake_minimum_required(VERSION 3.25)

# Project name
project(RuntimeCheck CXX)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)


### Main Setup ###############################
# Add the executable target
add_executable(main.out main.cpp add.cpp)

# Add the include directory for the executable target
add_custom_target(run
    COMMAND ./main.out
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    DEPENDS main.out
    COMMENT "Running the application..."
)

### GoogleTest Setup ###############################
# Enable testing for GoogleTest
enable_testing()

# Add the executable target for add_test.cpp
add_executable(add_test add_test.cpp add.cpp)

# Specify the path to the installed GoogleTest
find_package(GTest REQUIRED)

# Link GoogleTest libraries
target_link_libraries(add_test GTest::gtest_main GTest::gtest)

# Discover GoogleTest tests
include(GoogleTest)
gtest_discover_tests(add_test)

# Add a custom target to run tests
add_custom_target(run_tests
    COMMAND ctest --output-on-failure
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    DEPENDS add_test
    COMMENT "Running GoogleTest tests..."
)