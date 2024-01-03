message("${PROJECT_NAME} - Added CMake Script all.cmake")

# inc all cmake files from the cmake directory
file(GLOB_RECURSE INCLUDES "cmake/*.cmake")
foreach (INCLUDE ${INCLUDES})
    get_filename_component(INCLUDE_NAME "${INCLUDE}" NAME)
    if (NOT INCLUDE_NAME STREQUAL "all.cmake")
        include(${INCLUDE})
        message("${PROJECT_NAME} - Added CMake Script ${INCLUDE_NAME}")
    endif ()
endforeach ()
