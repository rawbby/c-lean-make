function(add_libraries_directory LIBRARIES_REL_DIR)

    file(GLOB_RECURSE TARGET_PATHS "${LIBRARIES_REL_DIR}/**/target.cmake")
    foreach (TARGET_PATH ${TARGET_PATHS})

        get_filename_component(TARGET_ABS_PATH "${TARGET_PATH}" ABSOLUTE)
        get_filename_component(TARGET_ABS_DIR "${TARGET_ABS_PATH}" DIRECTORY)
        file(RELATIVE_PATH TARGET_REL_DIR "${CMAKE_CURRENT_LIST_DIR}/${LIBRARIES_REL_DIR}" ${TARGET_ABS_DIR})

        set(TARGET_NAME "${TARGET_REL_DIR}")

        foreach (LOWER_LETTER a b c d e f g h i j k l m n o p q r s t u v w x y z)
            string(TOUPPER ${LOWER_LETTER} UPPER_LETTER)
            string(REGEX REPLACE "${UPPER_LETTER}" "${LOWER_LETTER}" TARGET_NAME ${TARGET_NAME})
        endforeach ()

        string(REPLACE "-" "_" TARGET_NAME ${TARGET_NAME})
        string(REPLACE " " "_" TARGET_NAME ${TARGET_NAME})
        string(REPLACE "/" "_" TARGET_NAME ${TARGET_NAME})
        string(REPLACE "\\" "_" TARGET_NAME ${TARGET_NAME})

        file(GLOB_RECURSE TARGET_HEADER
                "${TARGET_ABS_DIR}/inc/*.hpp")

        file(GLOB_RECURSE TARGET_SOURCE
                "${TARGET_ABS_DIR}/src/*.hpp"
                "${TARGET_ABS_DIR}/src/*.cpp")

        if (TARGET_SOURCE)
            add_library(${TARGET_NAME} STATIC)
            target_sources(${TARGET_NAME} PUBLIC ${TARGET_HEADER})
            target_sources(${TARGET_NAME} PRIVATE ${TARGET_SOURCE})
        else ()
            add_library(${TARGET_NAME} INTERFACE)
            target_sources(${TARGET_NAME} INTERFACE ${TARGET_HEADER})
        endif ()

        target_include_directories(${TARGET_NAME} INTERFACE "${TARGET_ABS_DIR}/inc")

        set_target_properties(${TARGET_NAME} PROPERTIES
                LINKER_LANGUAGE CXX
                CXX_STANDARD 20
                CXX_STANDARD_REQUIRED ON)

        include("${TARGET_ABS_PATH}")

        message("${PROJECT_NAME} - Added Library      ${TARGET_NAME}")

    endforeach ()

endfunction()
