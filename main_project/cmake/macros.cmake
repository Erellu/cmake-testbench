#------------------------------------------------------------------------------
# Sets up variables used for the building process (install directory, compiler, etc)
# WARNING: calling this function twice with different arguments will result in libraries being
# considered as from different projects, hence installed at different places and in a different export set.
# You should usually call it only once from the main CMakeLists.txt.
# If you need to call it twice (for subprojects for example), call cmake_testbench_finalise() first.
########################################
# param: current_project_name    - Name of the current project, as STRING.
# param: current_project_version - Version of the project.
#
# output: sets the following variables:
#    Variables (constants):
#       CMAKE_TESTBENCH_PROJECT                         --- Project name. Value of 'current_project_name'.
#       ${CMAKE_TESTBENCH_PROJECT}_NAMESPACE            --- Namespace of the exported targets.
#
#       ${CMAKE_TESTBENCH_PROJECT}_INSTALL_PREFIX       --- Where the installation is performed.
#       ${CMAKE_TESTBENCH_PROJECT}_RUNTIME_DESTINATION  --- Where the binaries are installed.
#       ${CMAKE_TESTBENCH_PROJECT}_ARCHIVE_DESTINATION  --- Where the libraries are installed.
#       ${CMAKE_TESTBENCH_PROJECT}_LIBRARY_DESTINATION  --- Where the libraries are installed (also).
#       ${CMAKE_TESTBENCH_PROJECT}_INCLUDES_DESTINATION --- Where the headers are installed.
#       ${CMAKE_TESTBENCH_PROJECT}_INCLUDES_INSTALL_DIR --- Where the headers are installed.
#       ${CMAKE_TESTBENCH_PROJECT}_GENERATED_DIR        --- Where the CMake-generated files are put.
#
#       ${CMAKE_TESTBENCH_PROJECT}_VERSION_CONFIG       --- Name of the CMake version config file.
#       ${CMAKE_TESTBENCH_PROJECT}_PROJECT_CONFIG       --- Name of the CMake config file.
#
#       ${CMAKE_TESTBENCH_PROJECT}_TARGETS_EXPORT_NAME  --- Export set for the targets added using cmake_testbench_add_library.
#       ${CMAKE_TESTBENCH_PROJECT}_EXPORT_NAME          --- Name of CMake Targets file.
#       ${CMAKE_TESTBENCH_PROJECT}_CONFIG_INSTALL_DIR   --- Where to install cmake "Targets" files.
#
#        CMAKE_TESTBENCH_WARNINGS                       --- A list of warnings enabled for the compiler in use.
#        CMAKE_TESTBENCH_COMPILER                       --- The compiler in use. Either "gcc", "mingw", "clang" or "msvc".
#    Flags:
#        CMAKE_TESTBENCH_SETUP                          --- A flag indicating this function was call. Unsetting it or setting a value that is not 'TRUE' will lead to the impossibility to call cmake_testbench_finalise().
#    Properties:
#        ${CMAKE_TESTBENCH_PROJECT}_components          --- Global property to which target added through cmake_testbench_add_library are added.
#
# These names are RESERVED and **MUST NOT** be changed manually (read-only access is fine).

macro(cmake_testbench_setup)

    #----------------------------------------------------------------
    # Arguments

    set(cmake_testbench_setup_optional_value_args_identifiers)

    set(cmake_testbench_setup_single_value_args_identifiers
        NAME
        INSTALLATION
    )

    set(cmake_testbench_setup_multi_value_args_identifiers)

    cmake_parse_arguments(cmake_testbench_setup
                          "${cmake_testbench_setup_optional_value_args_identifiers}"
                          "${cmake_testbench_setup_single_value_args_identifiers}"
                          "${cmake_testbench_setup_multi_value_args_identifiers}"
                          ${ARGN})

    # See https://github.com/schweitzer/modern-cmake-tutorial
    # https://github.com/IRCAD/modern-cmake-tutorial
    # From https://github.com/schweitzer/modern-cmake-tutorial/blob/master/library/CMakeLists.txt

    #----------------------------------------------------------------
    # Sanity checks

    if(DEFINED CMAKE_TESTBENCH_SETUP)
        message(FATAL_ERROR "cmake_testbench_setup already called. If this is intentional, please call cmake_testbench_finalise first.")
    endif()

    if("${cmake_testbench_setup_NAME}" STREQUAL "")
        message(FATAL_ERROR "Project name must not be empty.")
    endif()

    if(NOT "${cmake_testbench_setup_INSTALLATION}" STREQUAL "ON" AND NOT "${cmake_testbench_setup_INSTALLATION}" STREQUAL "OFF")
        message(FATAL_ERROR "Invalid argument for INSTALLATION. Expected ON or OFF")
    endif()

    if(DEFINED CMAKE_TESTBENCH_PROJECT AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable 'CMAKE_TESTBENCH_PROJECT' is already set. It will be overriden by macro cmake_testbench_setup.")
    endif()

    # Set again later for readability
    set(CMAKE_TESTBENCH_PROJECT "${cmake_testbench_setup_NAME}")
    string(TOUPPER "${CMAKE_TESTBENCH_PROJECT}" CMAKE_TESTBENCH_PROJECT_UPPER)

    if(DEFINED ${CMAKE_TESTBENCH_PROJECT}_NAMESPACE AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable '${CMAKE_TESTBENCH_PROJECT}_NAMESPACE' is already set. It will be overriden by macro cmake_testbench_setup.")
    endif()

    if(DEFINED ${CMAKE_TESTBENCH_PROJECT}_RUNTIME_DESTINATION AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable '${CMAKE_TESTBENCH_PROJECT}_RUNTIME_DESTINATION' is already set. It will be overriden by macro cmake_testbench_setup.")
    endif()

    if(DEFINED ${CMAKE_TESTBENCH_PROJECT}_ARCHIVE_DESTINATION AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable '${CMAKE_TESTBENCH_PROJECT}_ARCHIVE_DESTINATION' is already set. It will be overriden by macro cmake_testbench_setup.")
    endif()

    if(DEFINED ${CMAKE_TESTBENCH_PROJECT}_INCLUDES_DESTINATION AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable '${CMAKE_TESTBENCH_PROJECT}_INCLUDES_DESTINATION' is already set. It will be overriden by macro cmake_testbench_setup.")
    endif()

    if(DEFINED ${CMAKE_TESTBENCH_PROJECT}_INCLUDES_INSTALL_DIR  AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable '${CMAKE_TESTBENCH_PROJECT}_INCLUDES_INSTALL_DIR' is already set. It will be overriden by macro cmake_testbench_setup.")
    endif()

    if(DEFINED ${CMAKE_TESTBENCH_PROJECT}_GENERATED_DIR AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable '${CMAKE_TESTBENCH_PROJECT}_GENERATED_DIR' is already set. It will be overriden by macro cmake_testbench_setup.")
    endif()

    if(DEFINED ${CMAKE_TESTBENCH_PROJECT}_VERSION_CONFIG AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable '${CMAKE_TESTBENCH_PROJECT}_VERSION_CONFIG' is already set. It will be overriden by macro cmake_testbench_setup.")
    endif()

    if(DEFINED ${CMAKE_TESTBENCH_PROJECT}_PROJECT_CONFIG AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable '${CMAKE_TESTBENCH_PROJECT}_PROJECT_CONFIG' is already set. It will be overriden by macro cmake_testbench_setup.")
    endif()

    if(DEFINED ${CMAKE_TESTBENCH_PROJECT}_TARGETS_EXPORT_NAME AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable '${CMAKE_TESTBENCH_PROJECT}_TARGETS_EXPORT_NAME' is already set. It will be overriden by macro cmake_testbench_setup.")
    endif()

    if(DEFINED ${CMAKE_TESTBENCH_PROJECT}_EXPORT_NAME AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable '${CMAKE_TESTBENCH_PROJECT}_EXPORT_NAME' is already set. It will be overriden by macro cmake_testbench_setup.")
    endif()

    if(DEFINED ${CMAKE_TESTBENCH_PROJECT}_CONFIG_INSTALL_DIR AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable '${CMAKE_TESTBENCH_PROJECT}_CONFIG_INSTALL_DIR' is already set. It will be overriden by macro cmake_testbench_setup.")
    endif()

    # No check for ${CMAKE_TESTBENCH_PROJECT}_components, since it's allowed to inherit that value for compatibility purposes

    #----------------------------------------------------------------
    # General setup

    set(CMAKE_TESTBENCH_PROJECT "${cmake_testbench_setup_NAME}")             # Project name
    set(${CMAKE_TESTBENCH_PROJECT}_NAMESPACE "${CMAKE_TESTBENCH_PROJECT}::") # Namespace of the exported targets

    set(${CMAKE_TESTBENCH_PROJECT}_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")
    set(${CMAKE_TESTBENCH_PROJECT}_RUNTIME_DESTINATION "${CMAKE_INSTALL_PREFIX}/bin")      # Where the binaries are installed
    set(${CMAKE_TESTBENCH_PROJECT}_ARCHIVE_DESTINATION "${CMAKE_INSTALL_PREFIX}/lib")      # Where the libraries are installed
    set(${CMAKE_TESTBENCH_PROJECT}_LIBRARY_DESTINATION "${CMAKE_INSTALL_PREFIX}/lib")      # Same
    set(${CMAKE_TESTBENCH_PROJECT}_INCLUDES_DESTINATION "${CMAKE_INSTALL_PREFIX}/include") # Where the headers are installed
    set(${CMAKE_TESTBENCH_PROJECT}_GENERATED_DIR "${CMAKE_CURRENT_BINARY_DIR}/generated")  # Where the CMake-generated files are put

    # Windows compatibility, CMake wants UNIX-style paths
    string(REPLACE "\\" "/" ${CMAKE_TESTBENCH_PROJECT}_INSTALL_PREFIX       "${${CMAKE_TESTBENCH_PROJECT}_INSTALL_PREFIX}")
    string(REPLACE "\\" "/" ${CMAKE_TESTBENCH_PROJECT}_RUNTIME_DESTINATION  "${${CMAKE_TESTBENCH_PROJECT}_RUNTIME_DESTINATION}")
    string(REPLACE "\\" "/" ${CMAKE_TESTBENCH_PROJECT}_ARCHIVE_DESTINATION  "${${CMAKE_TESTBENCH_PROJECT}_ARCHIVE_DESTINATION}")
    string(REPLACE "\\" "/" ${CMAKE_TESTBENCH_PROJECT}_LIBRARY_DESTINATION  "${${CMAKE_TESTBENCH_PROJECT}_LIBRARY_DESTINATION}")
    string(REPLACE "\\" "/" ${CMAKE_TESTBENCH_PROJECT}_INCLUDES_DESTINATION "${${CMAKE_TESTBENCH_PROJECT}_INCLUDES_DESTINATION}")
    string(REPLACE "\\" "/" ${CMAKE_TESTBENCH_PROJECT}_GENERATED_DIR        "${${CMAKE_TESTBENCH_PROJECT}_GENERATED_DIR}")

    set(${CMAKE_TESTBENCH_PROJECT}_INCLUDES_INSTALL_DIR "${${CMAKE_TESTBENCH_PROJECT}_INCLUDES_DESTINATION}")                              # Where the headers are installed
    set(${CMAKE_TESTBENCH_PROJECT}_VERSION_CONFIG "${${CMAKE_TESTBENCH_PROJECT}_GENERATED_DIR}/${CMAKE_TESTBENCH_PROJECT}-config-version.cmake") # Name of the CMake version config file.
    set(${CMAKE_TESTBENCH_PROJECT}_PROJECT_CONFIG "${${CMAKE_TESTBENCH_PROJECT}_GENERATED_DIR}/${CMAKE_TESTBENCH_PROJECT}-config.cmake")         # Name of the CMake config file.

    set(${CMAKE_TESTBENCH_PROJECT}_TARGETS_EXPORT_NAME "${CMAKE_TESTBENCH_PROJECT}_targets")  # Export set for the targets added using cmake_testbench_add_library.
    set(${CMAKE_TESTBENCH_PROJECT}_EXPORT_NAME "${CMAKE_TESTBENCH_PROJECT}-targets")          # Name of CMake Targets file
    set(${CMAKE_TESTBENCH_PROJECT}_CONFIG_INSTALL_DIR "lib/cmake/${CMAKE_TESTBENCH_PROJECT}") # Where to install cmake "Targets" files

    get_property(current_${CMAKE_TESTBENCH_PROJECT}_components GLOBAL PROPERTY ${CMAKE_TESTBENCH_PROJECT}_components)

    if("${current_${CMAKE_TESTBENCH_PROJECT}_components}" STREQUAL "")
        set_property(GLOBAL PROPERTY ${CMAKE_TESTBENCH_PROJECT}_components "") # Don't override user contents in this context
    endif()

    if("${cmake_testbench_setup_INSTALLATION}" STREQUAL "ON")
        set(${CMAKE_TESTBENCH_PROJECT}_INSTALLATION TRUE)
    else()
        set(${CMAKE_TESTBENCH_PROJECT}_INSTALLATION FALSE)
    endif()

    unset(current_${CMAKE_TESTBENCH_PROJECT}_components)

    #----------------------------------------------------------------
    # Compiler

    if (MINGW OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")

        if(MINGW)
            set(CMAKE_TESTBENCH_COMPILER "mingw")
            get_filename_component(Mingw_Path ${CMAKE_CXX_COMPILER} PATH)
            set(CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS
                ${Mingw_Path}/libgcc_s_seh-1.dll ${Mingw_Path}/libstdc++-6.dll ${Mingw_Path}/libwinpthread-1.dll
            )
            # Allow (very) big object files. This is needed for extension functions
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wa,-mbig-obj")
        else()
            set(CMAKE_TESTBENCH_COMPILER "gcc")
        endif()

    elseif(MSVC)

        set(CMAKE_TESTBENCH_COMPILER "msvc")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNOMINMAX -DWIN32_LEAN_AND_MEAN /bigobj")

    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")

        set(CMAKE_TESTBENCH_COMPILER "clang")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wa,-mbig-obj") # Not sure, will need some checks

    endif()

    if(${${CMAKE_TESTBENCH_PROJECT}_INSTALLATION})
        include(InstallRequiredSystemLibraries)
    endif()

    cmake_testbench_setup_warning_list()

    #----------------------------------------------------------------
    # Flags

    set(CMAKE_TESTBENCH_SETUP TRUE)

endmacro() # cmake_testbench_setup

#------------------------------------------------------------------------------
# Finalises the build process for the current project.
########################################
#
# output: unsets CMAKE_TESTBENCH_SETUP and CMAKE_TESTBENCH_PROJECT, allowing to call cmake_testbench_setup again for another subproject.
# Other variables set by cmake_testbench_setup are left untouched.

macro(cmake_testbench_finalise)

    if(NOT DEFINED CMAKE_TESTBENCH_SETUP OR NOT ${CMAKE_TESTBENCH_SETUP})
        message(FATAL_ERROR "cmake_testbench_setup(...) not called yet.")
    endif()

    #----------------------------------------------------------------
    # Display all installed targets for project

    get_property(CMAKE_TESTBENCH_PROJECT_components_value GLOBAL PROPERTY ${CMAKE_TESTBENCH_PROJECT}_components)
    if("${CMAKE_TESTBENCH_PROJECT}_components_value}" STREQUAL "")
        message(FATAL_ERROR "No targets to export. Something went wrong :(")
    elseif(CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(STATUS "The following components (available in property ${CMAKE_TESTBENCH_PROJECT}_components) will be exported: ${CMAKE_TESTBENCH_PROJECT_components_value}")
    endif()

    #----------------------------------------------------------------
    # Configure file

    # See
    # https://github.com/schweitzer/modern-cmake-tutorial
    # https://github.com/IRCAD/modern-cmake-tutorial
    # From https://github.com/schweitzer/modern-cmake-tutorial/blob/master/library/CMakeLists.txt

    if(${${CMAKE_TESTBENCH_PROJECT}_INSTALLATION})
        write_basic_package_version_file(
            "${${CMAKE_TESTBENCH_PROJECT}_VERSION_CONFIG}"
            VERSION ${${CMAKE_TESTBENCH_PROJECT}_VERSION}
            COMPATIBILITY SameMajorVersion
        )

        # Configure the config.cmake.in
        configure_file(
            "${${CMAKE_TESTBENCH_PROJECT}_SOURCE_DIR}/cmake/config.cmake.in"
            "${${CMAKE_TESTBENCH_PROJECT}_PROJECT_CONFIG}"
            @ONLY
        )

        # Install cmake config files
        install(
            FILES "${${CMAKE_TESTBENCH_PROJECT}_PROJECT_CONFIG}" "${${CMAKE_TESTBENCH_PROJECT}_VERSION_CONFIG}"
            DESTINATION "${${CMAKE_TESTBENCH_PROJECT}_CONFIG_INSTALL_DIR}"
        )

        # Install cmake targets files
        install(
            EXPORT "${${CMAKE_TESTBENCH_PROJECT}_TARGETS_EXPORT_NAME}"
            NAMESPACE "${${CMAKE_TESTBENCH_PROJECT}_NAMESPACE}"
            DESTINATION "${${CMAKE_TESTBENCH_PROJECT}_CONFIG_INSTALL_DIR}"
        )

        # Install compiler-specific runtime libs (required for MinGW)
        if(CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS)
            install(PROGRAMS ${CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS}
                    DESTINATION ${${CMAKE_TESTBENCH_PROJECT}_RUNTIME_DESTINATION}
                    COMPONENT System
            )
        endif()
    endif()

    #----------------------------------------------------------------
    # Unset flags

    unset(CMAKE_TESTBENCH_SETUP)
    unset(CMAKE_TESTBENCH_PROJECT)

    #----------------------------------------------------------------
    # Clear

    unset(CMAKE_TESTBENCH_PROJECT_components_value)

endmacro() # cmake_testbench_finalise

#------------------------------------------------------------------------------
# Creates a target from the sources given, links it to the libraries
# given, installs it and updates the target list.
########################################
# param: NAME                 - Name of the library. Prefix "${CMAKE_TESTBENCH_PROJECT}_" is appended automatically.
#                               EXPORT_NAME property is set to ${NAME}.
# param: TYPE                 - Target type. Either "LIBRARY" or "EXECUTABLE"
# param: PUBLIC_DEPENDENCIES  - Targets that must be build before this one and linked publicly.
# param: PRIVATE_DEPENDENCIES - Targets that must be build before this one and linked privately.
# param: HEADERS              - Library headers.
# param: SOURCES              - Library sources.
# param: PUBLIC_LINK          - Libraries to link publicly.
# param: PRIVATE_LINK         - Libraries to link privately.
# output: Creates a shared library according to the given information.
# Also handles installation and components updates.
#
# prerequisites: cmake_testbench_setup must have been called before.
#
# side effect: adds the follwing private definition: ${CMAKE_TESTBENCH_PROJECT}_${NAME}_COMPILE.
#
########################################
# Note:
# This macro is inspired by Sight CMake build commands.
# See
# https://git.ircad.fr/sight/sight/-/tree/dev/cmake
# Copyright notice (COPYING.LESSER)
#
################################################################################
#             GNU LESSER GENERAL PUBLIC LICENSE
#
# Sight is: Copyright (C) 2009-2020 IRCAD France
#           Copyright (C) 2012-2020 IHU Strasbourg
# Contact: sds.ircad@ircad.fr
#
# You may use, distribute and copy Sight under the terms of
# GNU Lesser General Public License version 3, which is displayed below.
# This license makes reference to the version 3 of the GNU General
# Public License, which you can find in the COPYING file.
################################################################################
#
# Rest is cut for clarity. See https://github.com/IRCAD/sight/blob/dev/COPYING.LESSER.
macro(cmake_testbench_add_target)

    #----------------------------------------------------------------
    # Sanity checks

    if(NOT DEFINED CMAKE_TESTBENCH_SETUP)
        message(FATAL_ERROR "cmake_testbench_setup(...) not called yet.")
    endif()

    if(DEFINED current_project AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable 'current_project' is already set. It will be overriden by macro cmake_testbench_add_library.")
    endif()

    if(DEFINED current_target_upper AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable 'current_target_upper' is already set. It will be overriden by macro cmake_testbench_add_library.")
    endif()

    if(DEFINED current_source_dir_relative_path AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable 'current_source_dir_relative_path' is already set. It will be overriden by macro cmake_testbench_add_library.")
    endif()

    if(DEFINED current_source_dirs AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable 'current_source_dirs' is already set. It will be overriden by macro cmake_testbench_add_library.")
    endif()

    if(DEFINED path_root AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable 'path_root' is already set. It will be overriden by macro cmake_testbench_add_library.")
    endif()

    if(DEFINED headers_destination_relative_path AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable 'headers_destination_relative_path' is already set. It will be overriden by macro cmake_testbench_add_library.")
    endif()

    if(DEFINED stripped_relative_path AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable 'stripped_relative_path' is already set. It will be overriden by macro cmake_testbench_add_library.")
    endif()

    if(DEFINED components AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable 'stripped_relative_path' is already set. It will be overriden by macro cmake_testbench_add_library.")
    endif()

    if(DEFINED public_deps AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable 'public_deps' is already set. It will be overriden by macro cmake_testbench_add_library.")
    endif()

    if(DEFINED private_deps AND CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(WARNING "Variable 'private_deps' is already set. It will be overriden by macro cmake_testbench_add_library.")
    endif()

    #----------------------------------------------------------------
    # Arguments

    set(cmake_testbench_add_target_optional_args_identifiers)

    set(cmake_testbench_add_target_single_value_args_identifiers)

    set(cmake_testbench_add_target_multi_value_args_identifiers
        NAME
        TYPE
        PUBLIC_DEPENDENCIES
        PRIVATE_DEPENDENCIES
        HEADERS
        SOURCES
        PUBLIC_LINK
        PRIVATE_LINK
    )

    cmake_parse_arguments(cmake_testbench_target
                          "${cmake_testbench_add_target_optional_args_identifiers}"
                          "${cmake_testbench_add_target_single_value_args_identifiers}"
                          "${cmake_testbench_add_target_multi_value_args_identifiers}"
                          ${ARGN})

    #----------------------------------------------------------------
    # Project name

    set(current_project "${cmake_testbench_target_NAME}")
    string(TOUPPER "${CMAKE_TESTBENCH_PROJECT}_${current_project}" current_target_upper)

    if(current_project STREQUAL "")
        message(FATAL_ERROR "Cannot configure a project with an empty name.")
    endif()

    if(CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(STATUS "Configuring ${CMAKE_TESTBENCH_PROJECT}::${current_project}...")
    endif()

    #----------------------------------------------------------------
    # Build

    if(cmake_testbench_target_TYPE STREQUAL "LIBRARY")
        add_library(${CMAKE_TESTBENCH_PROJECT}_${current_project} SHARED
                    ${cmake_testbench_target_HEADERS}
                    ${cmake_testbench_target_SOURCES}
        )
    elseif(cmake_testbench_target_TYPE STREQUAL "EXECUTABLE")
        add_executable(${CMAKE_TESTBENCH_PROJECT}_${current_project}
                       ${cmake_testbench_target_HEADERS}
                       ${cmake_testbench_target_SOURCES}
        )
    else()
        message(FATAL_ERROR "Invalid argument (${cmake_testbench_target_TYPE}) for TYPE. Must be 'LIBRARY' or 'EXECUTABLE' (case-sensitive).")
    endif()

    set_property(TARGET ${CMAKE_TESTBENCH_PROJECT}_${current_project} PROPERTY EXPORT_NAME ${current_project})

    # Public dependencies (public link dependency)
    if(NOT "${cmake_testbench_target_PUBLIC_DEPENDENCIES}" STREQUAL "")

        string(REPLACE ";" ";" public_deps "${cmake_testbench_target_PUBLIC_DEPENDENCIES}")

        foreach(dependency ${public_deps})
            add_dependencies(${CMAKE_TESTBENCH_PROJECT}_${current_project} "${CMAKE_TESTBENCH_PROJECT}_${dependency}")
            target_link_libraries(${CMAKE_TESTBENCH_PROJECT}_${current_project} PUBLIC "${CMAKE_TESTBENCH_PROJECT}_${dependency}")
        endforeach()

        unset(public_deps)

    endif()

    # Public dependencies (public link dependency)
    if(NOT "${cmake_testbench_target_PRIVATE_DEPENDENCIES}" STREQUAL "")

        string(REPLACE ";" ";" private_deps "${cmake_testbench_target_PRIVATE_DEPENDENCIES}")

        foreach(dependency ${private_deps})
            add_dependencies(${CMAKE_TESTBENCH_PROJECT}_${current_project} "${CMAKE_TESTBENCH_PROJECT}_${dependency}")
            target_link_libraries(${CMAKE_TESTBENCH_PROJECT}_${current_project} PRIVATE "${CMAKE_TESTBENCH_PROJECT}_${dependency}")
        endforeach()

        unset(private_deps)

    endif()

    # Header locations
    target_include_directories(
        ${CMAKE_TESTBENCH_PROJECT}_${current_project}
        PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/libs/>
               $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/include>
               $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/include/${CMAKE_TESTBENCH_PROJECT}> # For files including stuff like <common/macros.hpp>
    )

    target_compile_definitions(${CMAKE_TESTBENCH_PROJECT}_${current_project} PRIVATE "${CMAKE_TESTBENCH_PROJECT_UPPER}_COMPILE")

    # Libraries to link against
    target_link_libraries(${CMAKE_TESTBENCH_PROJECT}_${current_project} PUBLIC ${cmake_testbench_target_PUBLIC_LINK})
    target_link_libraries(${CMAKE_TESTBENCH_PROJECT}_${current_project} PRIVATE ${cmake_testbench_target_PRIVATE_LINK})

    # Target warnings
    if(cmake_testbench_target_TYPE STREQUAL "LIBRARY")
        target_compile_options(${CMAKE_TESTBENCH_PROJECT}_${current_project} PRIVATE ${CMAKE_TESTBENCH_WARNINGS})
    endif()

    #----------------------------------------------------------------
    # Install

    if(cmake_testbench_target_TYPE STREQUAL "LIBRARY")

        # Get the directory names from project root
        file(RELATIVE_PATH current_source_dir_relative_path ${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR})
        string(REPLACE "/" ";" current_source_dirs ${current_source_dir_relative_path})
        list(GET current_source_dirs 0 path_root)

        if("${path_root}" STREQUAL "libs")

            # Install path, same as current directory but in installation directory
            list(POP_FRONT current_source_dirs)
            string(REPLACE ";" "/" stripped_relative_path "${current_source_dirs}")

            set(headers_destination_relative_path "${CMAKE_TESTBENCH_PROJECT}/${stripped_relative_path}")
            file(TO_CMAKE_PATH "${headers_destination_relative_path}" headers_destination_relative_path)
        else()
            message(FATAL_ERROR "Project is not in 'libs' folder. Cannot determine install path.")
        endif()

        if(CMAKE_TESTBENCH_VERBOSE_BUILD)
            message("    -- Installing to: ${${CMAKE_TESTBENCH_PROJECT}_INCLUDES_INSTALL_DIR}/${headers_destination_relative_path}")
        endif()

        if(${${CMAKE_TESTBENCH_PROJECT}_INSTALLATION})
            install(
                DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/
                DESTINATION ${${CMAKE_TESTBENCH_PROJECT}_INCLUDES_INSTALL_DIR}/${headers_destination_relative_path}
                FILES_MATCHING
                PATTERN "*.h"
                PATTERN "*.hpp"
                PATTERN "*.hxx"
                PATTERN "*.cuh"
                PATTERN "*.cuxx"
                PATTERN "test/*" EXCLUDE
                PATTERN "doxygen/*" EXCLUDE
                PATTERN "code_generation/*" EXCLUDE
            )
        endif()
    endif()

    if(${${CMAKE_TESTBENCH_PROJECT}_INSTALLATION})
        install(
            TARGETS ${CMAKE_TESTBENCH_PROJECT}_${current_project}
            EXPORT ${${CMAKE_TESTBENCH_PROJECT}_TARGETS_EXPORT_NAME}
            RUNTIME DESTINATION ${${CMAKE_TESTBENCH_PROJECT}_RUNTIME_DESTINATION}
            ARCHIVE DESTINATION ${${CMAKE_TESTBENCH_PROJECT}_ARCHIVE_DESTINATION}
            LIBRARY DESTINATION ${${CMAKE_TESTBENCH_PROJECT}_LIBRARY_DESTINATION}
            INCLUDES DESTINATION ${${CMAKE_TESTBENCH_PROJECT}_INCLUDES_INSTALL_DIR}
        )
    endif()

    #----------------------------------------------------------------
    # Targets update

    get_property(components GLOBAL PROPERTY ${CMAKE_TESTBENCH_PROJECT}_components)

    if("${components}" STREQUAL "")
        set_property(GLOBAL PROPERTY ${CMAKE_TESTBENCH_PROJECT}_components "${current_project}")
    else()
        set_property(GLOBAL PROPERTY ${CMAKE_TESTBENCH_PROJECT}_components "${components};${current_project}")
    endif()

    #----------------------------------------------------------------

    unset(current_project)
    unset(current_target_upper)
    unset(current_source_dir_relative_path)
    unset(current_source_dirs)
    unset(path_root)
    unset(headers_destination_relative_path)
    unset(stripped_relative_path)
    unset(components)

    if(CMAKE_TESTBENCH_VERBOSE_BUILD)
        message(STATUS "Done.")
    endif()
endmacro()

#------------------------------------------------------------------------------
# Creates a shared library from the sources given, links it to the libraries
# given, installs it and updates the target list.
########################################
# param: NAME                 - Name of the library. Prefix "${CMAKE_TESTBENCH_PROJECT}_" is appended automatically.
#                               EXPORT_NAME property is set to ${NAME}.
# param: PUBLIC_DEPENDENCIES  - Targets that must be build before this one and linked publicly.
# param: PRIVATE_DEPENDENCIES - Targets that must be build before this one and linked privately.
# param: HEADERS              - Library headers.
# param: SOURCES              - Library sources.
# param: PUBLIC_LINK          - Libraries to link publicly.
# param: PRIVATE_LINK         - Libraries to link privately.
# output: Creates a shared library according to the given information.
# Also handles installation and components updates.
#
# prerequisites: cmake_testbench_setup must have been called before.
macro(cmake_testbench_add_library)

    #----------------------------------------------------------------
    # Arguments

    set(cmake_testbench_add_library_optional_args_identifiers)

    set(cmake_testbench_add_library_single_value_args_identifiers)

    set(cmake_testbench_add_library_multi_value_args_identifiers
        NAME
        PUBLIC_DEPENDENCIES
        PRIVATE_DEPENDENCIES
        HEADERS
        SOURCES
        PUBLIC_LINK
        PRIVATE_LINK
    )

    cmake_parse_arguments(cmake_testbench_library
                          "${cmake_testbench_add_library_optional_args_identifiers}"
                          "${cmake_testbench_add_library_single_value_args_identifiers}"
                          "${cmake_testbench_add_library_multi_value_args_identifiers}"
                          ${ARGN})

    #----------------------------------------------------------------
    # Target

    cmake_testbench_add_target(NAME "${cmake_testbench_library_NAME}"
                         TYPE "LIBRARY"
                         PUBLIC_DEPENDENCIES "${cmake_testbench_library_PUBLIC_DEPENDENCIES}"
                         PRIVATE_DEPENDENCIES "${cmake_testbench_library_PRIVATE_DEPENDENCIES}"
                         HEADERS "${cmake_testbench_library_HEADERS}"
                         SOURCES "${cmake_testbench_library_SOURCES}"
                         PUBLIC_LINK "${cmake_testbench_library_PUBLIC_LINK}"
                         PRIVATE_LINK "${cmake_testbench_library_PRIVATE_LINK}"
                     )

endmacro() # cmake_testbench_add_library

#------------------------------------------------------------------------------
# Creates an executable from the sources given, links it to the libraries
# given, installs it and updates the target list.
########################################
# param: NAME                 - Name of the library. Prefix "${CMAKE_TESTBENCH_PROJECT}_" is appended automatically.
#                               EXPORT_NAME property is set to ${NAME}.
# param: PUBLIC_DEPENDENCIES  - Targets that must be build before this one and linked publicly.
# param: PRIVATE_DEPENDENCIES - Targets that must be build before this one and linked privately.
# param: HEADERS              - Library headers.
# param: SOURCES              - Library sources.
# param: PUBLIC_LINK          - Libraries to link publicly.
# param: PRIVATE_LINK         - Libraries to link privately.
# output: Creates a shared library according to the given information.
# Sets is
# Also handles installation and components updates.
#
# prerequisites: cmake_testbench_setup must have been called before.
#
macro(cmake_testbench_add_executable)

    #----------------------------------------------------------------
    # Arguments

    set(cmake_testbench_add_executable_optional_args_identifiers)

    set(cmake_testbench_add_executable_single_value_args_identifiers)

    set(cmake_testbench_add_executable_multi_value_args_identifiers
        NAME
        PUBLIC_DEPENDENCIES
        PRIVATE_DEPENDENCIES
        HEADERS
        SOURCES
        PUBLIC_LINK
        PRIVATE_LINK
    )

    cmake_parse_arguments(cmake_testbench_executable
                          "${cmake_testbench_add_executable_optional_args_identifiers}"
                          "${cmake_testbench_add_executable_single_value_args_identifiers}"
                          "${cmake_testbench_add_executable_multi_value_args_identifiers}"
                          ${ARGN})


    #----------------------------------------------------------------
    # Target

    cmake_testbench_add_target(NAME "${cmake_testbench_executable_NAME}"
                         TYPE "EXECUTABLE"
                         PUBLIC_DEPENDENCIES "${cmake_testbench_executable_PUBLIC_DEPENDENCIES}"
                         PRIVATE_DEPENDENCIES "${cmake_testbench_executable_PRIVATE_DEPENDENCIES}"
                         HEADERS "${cmake_testbench_executable_HEADERS}"
                         SOURCES "${cmake_testbench_executable_SOURCES}"
                         PUBLIC_LINK "${cmake_testbench_executable_PUBLIC_LINK}"
                         PRIVATE_LINK "${cmake_testbench_executable_PRIVATE_LINK}"
    )

endmacro() # cmake_testbench_add_executable

#------------------------------------------------------------------------------
