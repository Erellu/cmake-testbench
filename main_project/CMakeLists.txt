cmake_minimum_required(VERSION 3.14)
include(cmake/warning_setup.cmake)
include(cmake/macros.cmake)
include(CMakePackageConfigHelpers)

#------------------------------------------------------------------------------
# CMake options

set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING "Build type (Debug, Release)")
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug;Release")

if(NOT CMAKE_BUILD_TYPE STREQUAL "Debug" AND NOT CMAKE_BUILD_TYPE STREQUAL "Release")
    message(FATAL_ERROR "Invalid value for CMAKE_BUILD_TYPE: '${CMAKE_BUILD_TYPE}' (required either 'Debug' or 'Release')")
endif()

option(CMAKE_TESTBENCH_VERBOSE_BUILD "Display detailed messages when configuring." OFF)
option(CMAKE_TESTBENCH_INSTALL "Install to directory set in CMAKE_INSTALL_PREFIX." ON)

#------------------------------------------------------------------------------
# Project

project(cmake_testbench
        LANGUAGES CXX
        VERSION 1.0.0
        DESCRIPTION "Repository in which I test various stuff in CMake"
        HOMEPAGE_URL "https://github.com/Erellu/cmake-testbench"
)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#------------------------------------------------------------------------------
# Setup

cmake_testbench_setup(
    NAME "cmake_testbench"
    INSTALLATION ${CMAKE_TESTBENCH_INSTALL}
)

#------------------------------------------------------------------------------
# Targets

add_subdirectory(libs)
add_subdirectory(executable)

#------------------------------------------------------------------------------
# Finalisation

cmake_testbench_finalise()
