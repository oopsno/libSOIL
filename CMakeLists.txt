cmake_minimum_required(VERSION 3.0)
project(libSOIL VERSION 1.07)

include_directories(include)

file(GLOB SRC  src/*.c)
file(GLOB TEST src/*.cpp)

add_library(soil-shared SHARED ${SRC})
set_target_properties(soil-shared PROPERTIES OUTPUT_NAME SOIL)
if (APPLE)
    target_link_libraries(soil-shared "-framework OpenGL")
    target_link_libraries(soil-shared "-framework CoreFoundation")
endif(APPLE)

add_library(soil-static STATIC ${SRC})
set_target_properties(soil-static PROPERTIES OUTPUT_NAME SOIL)

if(WIN32)
add_executable(soil-test ${TEST})
target_link_libraries(soil-test soil-static)
endif()

