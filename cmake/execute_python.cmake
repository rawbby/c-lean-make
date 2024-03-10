include_guard(GLOBAL)
include("${CMAKE_SOURCE_DIR}/cmake/util.cmake")

function(internal_execute_process)

    unset(PROCESS_COMMAND)
    foreach (ARG IN LISTS ARGV)
        list(APPEND PROCESS_COMMAND ${ARG})
    endforeach ()

    execute_process(
            COMMAND ${PROCESS_COMMAND}
            RESULT_VARIABLE PROCESS_RESULT
            OUTPUT_VARIABLE PROCESS_OUTPUT
            ERROR_VARIABLE PROCESS_ERROR)

    if (NOT ${PROCESS_ERROR} EQUAL 0)
        list(JOIN PROCESS_COMMAND " " PROCESS_COMMAND)
        message(FATAL_ERROR
                "${PROJECT_NAME} - Executing Process failed with Exit Code ${PROCESS_RESULT}:\n"
                "${WHITESPACE} - ${PROCESS_COMMAND}\n"
                "${WHITESPACE} - ${PROCESS_ERROR}")
    endif ()

endfunction()

function(execute_python SCRIPT_PATH)

    if (NOT EXISTS "${SCRIPT_PATH}")
        message(FATAL_ERROR
                "${PROJECT_NAME} - Executing Process failed as the Script does not exist:\n"
                "${WHITESPACE} - ${SCRIPT_PATH}")
    endif ()

    if (WIN32)
        set(PYTHON_EXE python.exe)
        set(VENV_PYTHON_EXE "${CMAKE_BINARY_DIR}/.venv/Scripts/python.exe")
    else ()
        set(PYTHON_EXE python3)
        set(VENV_PYTHON_EXE "${CMAKE_BINARY_DIR}/.venv/bin/python")
    endif ()

    if (NOT EXISTS "${CMAKE_BINARY_DIR}/.venv")
        internal_execute_process("${PYTHON_EXE}" -m venv "${CMAKE_BINARY_DIR}/.venv")
    endif ()

    get_filename_component(SCRIPT_DIR "${SCRIPT_PATH}" DIRECTORY)
    if (EXISTS "${SCRIPT_DIR}/requirements.txt")
        internal_execute_process(${VENV_PYTHON_EXE} -m pip install --upgrade -r "${SCRIPT_DIR}/requirements.txt")
    endif ()

    internal_execute_process(${VENV_PYTHON_EXE} ${ARGV})

endfunction()
