cmake_testbench_add_executable(NAME executable_test
                               PUBLIC_DEPENDENCIES "common" "lib_a" "lib_b"
                               PRIVATE_DEPENDENCIES ""
                               HEADERS ""
                               SOURCES "main.cpp"
                               PUBLIC_LINK ""
                               PRIVATE_LINK ""
                           )
