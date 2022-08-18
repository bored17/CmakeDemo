cmake_minimum_required(VERSION 3.12.1)

project(main)

include(CMakePrintHelpers)

find_package(foo CONFIG REQUIRED)
cmake_print_variables(foo_FOUND)
cmake_print_variables(FOO_INCLUDE_DIR)
cmake_print_variables(FOO_LIBRARY_DIR)
cmake_print_variables(FOO_ARCHIVE_DIR)
cmake_print_variables(FOO_OBJECT_DIR)
cmake_print_variables(FOO_RUNTIME_DIR)
cmake_print_variables(FOO_CONFIG_DIR)

find_package(bar MODULE REQUIRED)
cmake_print_variables(bar_FOUND)
cmake_print_variables(BAR_INCLUDE_DIR)
cmake_print_variables(BAR_LIBRARY_DIR)
cmake_print_variables(BAR_ARCHIVE_DIR)
cmake_print_variables(BAR_OBJECT_DIR)
cmake_print_variables(BAR_RUNTIME_DIR)
cmake_print_variables(BAR_CONFIG_DIR)

add_executable(main main.c)

target_link_libraries(main PRIVATE foo::foo_shared foo::foo_static foo::foo_obj bar::bar_shared bar::bar_static bar::bar_obj)

file(RELATIVE_PATH _rel ${CMAKE_INSTALL_PREFIEX}/bin/main ${CMAKE_INSTALL_PREFIEX}/../foo/lib)

set(_rpath "\$ORIGIN/${_rel}")

file(TO_NATIVE_PATH "${_rpath}" message_RPATH)
file(RELATIVE_PATH _rel1 ${CMAKE_INSTALL_PREFIEX}/bin/main ${CMAKE_INSTALL_PREFIEX}/../bar/lib)

set(_rpath1 "\$ORIGIN/${_rel1}")

file(TO_NATIVE_PATH "${_rpath1}" message_RPATH1)

include(CMakePrintHelpers)
cmake_print_variables(message_RPATH)
set_target_properties(main 
    PROPERTIES
    MACOSX_RPATH ON
    SKIP_BUILD_RPATH OFF
    BUILD_WITH_INSTALL_RPATH OFF
    INSTALL_RPATH "${message_RPATH};${message_RPATH1}"
    INSTALL_PRATH_USE_LINK_PATH ON
)

install(TARGETS main DESTINATION bin)

