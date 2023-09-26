cmake_minimum_required(VERSION 3.5)

project(cmake_testbench_sub LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
find_package(cmake_testbench
             REQUIRED
             COMPONENTS lib_a lib_b)

add_executable(cmake_testbench_sub main.cpp)

target_link_libraries(cmake_testbench_sub PUBLIC
                                     cmake_testbench::lib_a
                                     cmake_testbench::lib_b)
