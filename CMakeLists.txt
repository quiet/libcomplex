cmake_minimum_required(VERSION 2.8)
project(Complex)
include(CheckLibraryExists)
include(CheckIncludeFiles)
include(CheckCXXSourceCompiles)

set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)

include_directories(${CMAKE_SOURCE_DIR}/include)
file(GLOB SRCFILES *.c)

set(INSTALL_HEADERS "${CMAKE_BINARY_DIR}/include/complex.hh")

add_custom_target(complex-h ALL COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/include/complex.h ${CMAKE_BINARY_DIR}/include/complex.h)

add_library(complex SHARED ${SRCFILES})
add_library(complex_static ${SRCFILES})
set_target_properties(complex_static PROPERTIES OUTPUT_NAME "complex")

install(TARGETS complex complex_static
        DESTINATION lib)
install(FILES ${INSTALL_HEADERS} DESTINATION "${CMAKE_INSTALL_PREFIX}/include")
