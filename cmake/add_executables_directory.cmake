function(add_executables_directory EXECUTABLES_REL_DIR)

    file(GLOB_RECURSE TARGET_PATHS "${EXECUTABLES_REL_DIR}/**/target.cmake")
    foreach (TARGET_PATH ${TARGET_PATHS})

        get_filename_component(TARGET_ABS_PATH "${TARGET_PATH}" ABSOLUTE)
        get_filename_component(TARGET_ABS_DIR "${TARGET_ABS_PATH}" DIRECTORY)
        file(RELATIVE_PATH TARGET_REL_DIR "${CMAKE_CURRENT_LIST_DIR}/${EXECUTABLES_REL_DIR}" ${TARGET_ABS_DIR})

        set(TARGET_NAME "${TARGET_REL_DIR}")

        foreach (LOWER_LETTER a b c d e f g h i j k l m n o p q r s t u v w x y z)
            string(TOUPPER ${LOWER_LETTER} UPPER_LETTER)
            string(REGEX REPLACE "${UPPER_LETTER}" "${LOWER_LETTER}" TARGET_NAME ${TARGET_NAME})
        endforeach ()

        string(REPLACE "-" "_" TARGET_NAME ${TARGET_NAME})
        string(REPLACE " " "_" TARGET_NAME ${TARGET_NAME})
        string(REPLACE "/" "_" TARGET_NAME ${TARGET_NAME})
        string(REPLACE "\\" "_" TARGET_NAME ${TARGET_NAME})

        file(GLOB_RECURSE TARGET_SOURCE
                "${TARGET_ABS_DIR}/src/*.hpp"
                "${TARGET_ABS_DIR}/src/*.cpp")

        add_executable(${TARGET_NAME})
        target_sources(${TARGET_NAME} PRIVATE ${TARGET_SOURCE})

        set_target_properties(${TARGET_NAME} PROPERTIES
                LINKER_LANGUAGE CXX
                CXX_STANDARD 20
                CXX_STANDARD_REQUIRED ON)

        include("${TARGET_ABS_PATH}")

        message("${PROJECT_NAME} - Added Executable   ${TARGET_NAME}")

    endforeach ()

endfunction()
