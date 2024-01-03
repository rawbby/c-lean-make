cmake_minimum_required(VERSION 3.5)

# setup project
set(PROJECT_NAME "vk")
project(${PROJECT_NAME} LANGUAGES CXX)

# inc all cmake util
include(cmake/all.cmake)

# add project components
add_libraries_directory(core)
add_executables_directory(tool)
add_tests_directory(test)
