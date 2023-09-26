cmake_testbench_add_library(NAME lib_b
                            PUBLIC_DEPENDENCIES "common" "lib_a"
                            PRIVATE_DEPENDENCIES ""
                            HEADERS "lib_b.hpp"
                            SOURCES "lib_b.cpp"
                            PUBLIC_LINK ""
                            PRIVATE_LINK ""
                        )

