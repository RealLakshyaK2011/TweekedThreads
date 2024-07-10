cmake_minimum_required(VERSION 3.27)

include(configurator.cmake)

######################### Project, target etc. stuff #########################

project(${PROJECT_NAME} VERSION ${PROJECT_VERSION})

set(TARGET ${PROJECT_NAME}_${PROJECT_VERSION})

set(SF "")

#Project files logic
function(get_files dir)
    file(GLOB found_files "${dir}/*")
    foreach(_file ${found_files})
        message(STATUS "${_file} in ${found_files}")
        if(IS_DIRECTORY ${_file})
            get_files(${_file})
        else()
            #Path normalization
            #replace / or \ with \ only of the working dir string
            string(REGEX REPLACE "[/\\]" "/" WD ${CMAKE_CURRENT_SOURCE_DIR})

            #replace / or \ with \ only of the file name string
            string(REGEX REPLACE "[/\\]" "/" FN ${_file})

            #Final string SUB_FILE_NAME to be concated
            string(REPLACE ${WD} "" SUB_FILE_NAME ${FN})

            string(SUBSTRING ${SUB_FILE_NAME} 0 1 FIRST_CHAR)

            if(FIRST_CHAR STREQUAL "/")
                string(LENGTH ${SUB_FILE_NAME} STR_LENGTH)

                math(EXPR subbed "${STR_LENGTH}-1" OUTPUT_FORMAT DECIMAL)

                string(SUBSTRING ${SUB_FILE_NAME} 1 ${subbed} SUB_FILE_NAME)

                set(SUB_FILE_NAME ${SUB_FILE_NAME} PARENT_SCOPE)
            endif()

            if("${SF}" STREQUAL "")
                string(CONCAT SF "${SUB_FILE_NAME}")
            else()
                string(CONCAT SF "${SF}" ";" "${SUB_FILE_NAME}")
            endif()
            set(SF ${SF} PARENT_SCOPE)
        endif()

    endforeach()
    message("SF: ${SF}")
    set(SOURCE_FILES ${SF} PARENT_SCOPE)
endfunction()

message(STATUS "--------------------------------------------------Source Files Debug: --------------------------------------------------")
get_files(src)
message(STATUS "-------------------------------------------------Source Files Debug End-------------------------------------------------")
message(STATUS "")
message(STATUS "---------------CURRENT PROJECT FILES INCLUDED: ---------------")
message(STATUS "${SOURCE_FILES}")
message(STATUS "--------------------------------------------------------------")

# add_executable("${TARGET}" "${SOURCE_FILES}")
add_library("${TARGET}" "${SOURCE_FILES}")