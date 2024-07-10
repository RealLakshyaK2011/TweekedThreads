#Load Project Configuration from project.conf
set(conf_file "${CMAKE_CURRENT_SOURCE_DIR}/project.conf")

if(NOT EXISTS ${conf_file})
    message(FATAL_ERROR "Can't load project configurations, project.conf file missing!")
endif()

file(READ ${conf_file} conf_data)

string(REGEX REPLACE "[,\ \\\n]" ";" conf_data ${conf_data})

message(STATUS ${conf_data})
message(STATUS "-------------------------Configurations Debug: -------------------------")
foreach(conf ${conf_data})
    string(REGEX REPLACE "\"*\"" "" conf ${conf})    

    string(FIND ${conf} "=" equal_seperator_pos)
    string(LENGTH ${conf} string_length)

    math(EXPR value_start "${equal_seperator_pos} + 1")
    math(EXPR value_len "${string_length} - ${value_start}")

    set(key_start 0)
    set(key_len ${equal_seperator_pos})

    string(SUBSTRING ${conf} ${key_start} ${key_len} key)
    string(SUBSTRING ${conf} ${value_start} ${value_len} value)

    set(${key} ${value})
    message(STATUS "Key: ${key} got set to Value: ${value}, key_start: ${key_start}, key_len: ${key_len}, 
            value_start: ${value_start}, value_len: ${value_len}")
endforeach()

message(STATUS "-----------------------Configurations Debug End: -----------------------")
message(STATUS "")