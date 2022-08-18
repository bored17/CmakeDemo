cmake_minimum_required(VERSION 3.14.1)

project(bar)

add_library(bar_shared SHARED bar_shared.c)

target_include_directories(bar_shared PUBLIC 
                           $<INSTALL_INTERFACE:include>
                           $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)

target_compile_definitions(bar_shared PUBLIC -DBAR_SHARED)

target_compile_options(bar_shared PUBLIC -Wall)

add_library(bar_static STATIC bar_static.c)

add_executable(bar_exe bar_exe.c)

add_library(bar_obj OBJECT bar_obj1.c bar_obj2.c)

set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_ARCHIVE_DIR lib)
set(INSTALL_OBJECT_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR lib/cmake)


install(TARGETS bar_shared bar_static bar_exe bar_obj
    LIBRARY DESTINATION
    ${INSTALL_LIBRARY_DIR}
    ARCHIVE DESTINATION
    ${INSTALL_ARCHIVE_DIR}
    OBJECTS DESTINATION
    ${INSTALL_OBJECT_DIR}
    RUNTIME DESTINATION
    ${INSTALL_RUNTIME_DIR})

install(DIRECTORY include/ DESTINATION
      ${INSTALL_INCLUDE_DIR})

install(FILES Findbar.cmake DESTINATION
       ${INSTALL_CONFIG_DIR})





