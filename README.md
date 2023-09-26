# cmake-testbench

Repository in which I test various stuff in CMake.

# Compiling

## `main_project`

- Clone the repository and pull its submodules.
- Run `cmake` (or `cmake-gui` if you prefer the graphical interface) and select the build system (`ninja`, etc.).
    - Set `CMAKE_BUILD_TYPE` to either `Debug` or `Release`.
    - Set the build directory to somewhere you have write access (like `/home/you/builds/cmake_testbench/debug-or-release/build`).
    - Set `CMAKE_INSTALL_PREFIX` to somewhere you have write access (like `/home/you/builds/cmake_testbench/debug-or-release/install`).
    - To toggle verbose build information, change `CMAKE_TESTBENCH_VERBOSE_BUILD` (default is **`ON`**)
    - To toggle the installation, change `CMAKE_TESTBENCH_INSTALL` (default is **`ON`**).
- `Configure` and then `Generate`.
- Go to your build directory and build (`ninja` or whatever you selected).

## `sub_project`

- Build `main_project` and install it.
- Set `cmake_testbench_DIR` to `your_install/lib/cmake/cmake_testbench`
- Change `CMAKE_INSTALL_PREFIX` to avoid polluting your system.
- Configure, generate, compile same as `main_project`.
