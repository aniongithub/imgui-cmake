set(component imgui-sdl)

set(OpenGL_GL_PREFERENCE "GLVND")
find_package(OpenGL REQUIRED)
find_package(SDL2 REQUIRED CONFIG)

add_library(${component} ${CMAKE_SOURCE_DIR}/imgui/backends/imgui_impl_sdl2.cpp)

# namespaced alias
add_library(${project}::${component} ALIAS ${component})

target_include_directories(${component}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/imgui/backends>
    $<INSTALL_INTERFACE:imgui_impl_sdl2.h>
    ${SDL2_INCLUDE_DIRS}
)

target_link_libraries(${component}
    ${OPENGL_LIBRARIES}
    imgui-core
    ${SDL2_LIBRARIES})

install(TARGETS ${component} EXPORT ${component}-targets
  COMPONENT ${component}
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
  INCLUDES DESTINATION include
)

install(EXPORT ${component}-targets
  FILE "${project}-${component}-targets.cmake"
  NAMESPACE ${project}::
  DESTINATION lib/cmake/${project}
  COMPONENT ${component}
)

configure_file("${component}-config.cmake.in"
  "${CMAKE_BINARY_DIR}/${project}-${component}-config.cmake"
  @ONLY
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_BINARY_DIR}/${project}-${component}-config-version.cmake"
  VERSION ${version}
  COMPATIBILITY AnyNewerVersion
)

install(
  FILES
    "${CMAKE_BINARY_DIR}/${project}-${component}-config.cmake"
    "${CMAKE_BINARY_DIR}/${project}-${component}-config-version.cmake"
  DESTINATION lib/cmake/${project}
  COMPONENT ${component}
)

install(
  FILES
  ${CMAKE_SOURCE_DIR}/imgui/backends/imgui_impl_sdl2.h
  COMPONENT ${component}
  DESTINATION ${CMAKE_INSTALL_PREFIX}/include
)