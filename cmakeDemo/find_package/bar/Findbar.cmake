get_filename_component(BAR_BASE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../" ABSOLUTE)

set(BAR_INCLUDE_DIR ${BAR_BASE_DIR}/include)
set(BAR_LIBRARY_DIR ${BAR_BASE_DIR}/lib)
set(BAR_ARCHIVE_DIR ${BAR_BASE_DIR}/lib)
set(BAR_OBJECT_DIR ${BAR_BASE_DIR}/lib)
set(BAR_RUNTIME_DIR ${BAR_BASE_DIR}/bin)
set(BAR_CONFIG_DIR ${BAR_BASE_DIR}/lib/cmake)


add_library(bar::bar_shared SHARED IMPORTED)

set_target_properties(bar::bar_shared
    PROPERTIES
    IMPORTED_LOCATION "${BAR_LIBRARY_DIR}/libbar_shared.so"
    INTERFACE_COMPILE_OPTIONS "-Wall"
    INTERFACE_COMPILE_DEFINITIONS "BAR_SHARED"
    INTERFACE_INCLUDE_DIRECTORIES "${BAR_INCLUDE_DIR}"
)

add_library(bar::bar_static STATIC IMPORTED)

set_target_properties(bar::bar_static
    PROPERTIES
    IMPORTED_LOCATION "${BAR_ARCHIVE_DIR}/libbar_static.a"
)

add_library(bar::bar_obj OBJECT IMPORTED)

set_target_properties(bar::bar_obj
    PROPERTIES
    IMPORTED_OBJECTS "${BAR_OBJECT_DIR}/objects-Release/bar_obj/bar_obj1.c.o;${BAR_OBJECT_DIR}/objects-Release/bar_obj/bar_obj2.c.o"
)

set(bar_FOUND TRUE)