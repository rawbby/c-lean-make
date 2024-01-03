C(LEAN)MAKE
===========

Project skeleton for less verbose CMake scripts.
Creates tree new ```add_directory``` commands that create magic directories.

```cmake
add_libraries_directory(<dir>)
add_executables_directory(<dir>)
add_tests_directory(<dir>)
```

add_libraries_directory(dir)
----------------------------

The libraries directory contains only libraries. Each subdirectory with a target.cmake file marks a library root.
A library is either static library or a header only library depending on the presence of a src directory. (src/ -> static_library)

In the target.cmake file the library target can be configured. The target is already created with the name ```${TARGET_NAME}```.

add_executables_directory(dir)
------------------------------

...

add_tests_directory(dir)
------------------------

...
