cmake_minimum_required(VERSION 3.14.1)

project(foo)

add_library(foo_shared SHARED foo_shared.c)

target_include_directories(foo_shared PUBLIC 
                            $<INSTALL_INTERFACE:include>
                            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)

target_compile_definitions(foo_shared PUBLIC -DFOO_SHARED)

target_compile_options(foo_shared PUBLIC -Wall)


add_library(foo_static STATIC foo_static.c)

add_executable(foo_exe foo_exe.c)

add_library(foo_obj OBJECT foo_obj1.c foo_obj2.c)



set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_ARCHIVE_DIR lib)
set(INSTALL_OBJECT_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR lib/cmake)




include(CMakePackageConfigHelpers)


install(TARGETS foo_shared foo_static foo_exe foo_obj 
    EXPORT foo-targets
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

install(EXPORT foo-targets 
    NAMESPACE foo::
    FILE foo-targets.cmake
    DESTINATION ${INSTALL_CONFIG_DIR})

configure_package_config_file(foo-config.cmake.in ${CMAKE_CURRENT_BINARY_DIR}/foo-config.cmake
    INSTALL_DESTINATION ${INSTALL_CONFIG_DIR}
    PATH_VARS INSTALL_BASE_DIR INSTALL_INCLUDE_DIR INSTALL_LIBRARY_DIR INSTALL_ARCHIVE_DIR INSTALL_OBJECT_DIR INSTALL_RUNTIME_DIR INSTALL_CONFIG_DIR
    INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/foo-config.cmake
        DESTINATION ${INSTALL_CONFIG_DIR})
