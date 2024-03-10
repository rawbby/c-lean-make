include_guard(GLOBAL)
include("${CMAKE_SOURCE_DIR}/cmake/util.cmake")

function(add_generator_directory TARGET_BASE_DIR TARGET_REL_DIR)

    get_filename_component(TARGET_ABS_DIR "${TARGET_BASE_DIR}/${TARGET_REL_DIR}" ABSOLUTE)

    target_name_from_rel_dir(TARGET_NAME "${TARGET_REL_DIR}")

    message("${PROJECT_NAME} - Starting Generator         ${TARGET_NAME} ...")
    include("${TARGET_ABS_DIR}/generate.cmake")

endfunction()
