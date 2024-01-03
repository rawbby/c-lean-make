option(BUILD_TESTING "Build Tests" OFF)
if (BUILD_TESTING)
    enable_testing()
endif ()

function(add_tests_directory TESTS_REL_DIR)

    if (BUILD_TESTING)

        get_filename_component(TESTS_ABS_PATH "${TESTS_REL_DIR}" ABSOLUTE)

        file(GLOB_RECURSE TARGET_PATHS "${TESTS_REL_DIR}/*.cpp")
        foreach (TARGET_PATH ${TARGET_PATHS})

            get_filename_component(TARGET_ABS_PATH "${TARGET_PATH}" ABSOLUTE)
            get_filename_component(TARGET_ABS_DIR "${TARGET_ABS_PATH}" DIRECTORY)
            file(RELATIVE_PATH TARGET_REL_DIR "${TESTS_ABS_PATH}" ${TARGET_ABS_DIR})

            get_filename_component(TARGET_NAME "${TARGET_PATH}" NAME_WE)
            set(TARGET_NAME "test_${TARGET_REL_DIR}_${TARGET_NAME}")

            foreach (LOWER_LETTER a b c d e f g h i j k l m n o p q r s t u v w x y z)
                string(TOUPPER ${LOWER_LETTER} UPPER_LETTER)
                string(REGEX REPLACE "${UPPER_LETTER}" "${LOWER_LETTER}" TARGET_NAME ${TARGET_NAME})
            endforeach ()

            string(REPLACE "." "_" TARGET_NAME ${TARGET_NAME})
            string(REPLACE "-" "_" TARGET_NAME ${TARGET_NAME})
            string(REPLACE " " "_" TARGET_NAME ${TARGET_NAME})
            string(REPLACE "/" "_" TARGET_NAME ${TARGET_NAME})
            string(REPLACE "\\" "_" TARGET_NAME ${TARGET_NAME})

            add_executable(${TARGET_NAME} "${TARGET_ABS_PATH}")
            set_target_properties(${TARGET_NAME} PROPERTIES
                    LINKER_LANGUAGE CXX
                    CXX_STANDARD 20
                    CXX_STANDARD_REQUIRED ON)

            set(TARGET_REL_DIR_PART ${TARGET_REL_DIR})
            while (TARGET_REL_DIR_PART)

                file(GLOB TARGET_CONFIG_PATH "${TESTS_ABS_PATH}/${TARGET_REL_DIR_PART}/config.cmake")
                if (TARGET_CONFIG_PATH)
                    include(${TARGET_CONFIG_PATH})
                endif ()

                get_filename_component(TARGET_REL_DIR_PART "${TARGET_REL_DIR_PART}" DIRECTORY)
            endwhile ()

            add_test(NAME "${TARGET_NAME}" COMMAND $<TARGET_FILE:${TARGET_NAME}>)

            message("${PROJECT_NAME} - Added Test         ${TARGET_NAME}")

        endforeach ()

    endif ()

endfunction()
