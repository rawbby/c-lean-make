include_guard(GLOBAL)

cmake_minimum_required(VERSION 3.17.5)

set(GENERATOR_SOURCE_DIR "${CMAKE_BINARY_DIR}/generated" CACHE INTERNAL "The root Directory for all generated Targets")

if (EXISTS "${GENERATOR_SOURCE_DIR}")
    file(REMOVE_RECURSE "${GENERATOR_SOURCE_DIR}")
endif ()
