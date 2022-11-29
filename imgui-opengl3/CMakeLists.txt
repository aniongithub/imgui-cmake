set(component imgui-opengl3)

set(OpenGL_GL_PREFERENCE "GLVND")
find_package(OpenGL REQUIRED)

set (srcs 
  ${CMAKE_SOURCE_DIR}/imgui/backends/imgui_impl_opengl3.cpp)
add_library(${component} ${srcs})

# namespaced alias
add_library(${project}::${component} ALIAS ${component})

target_include_directories(${component}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/imgui/backends>
    $<INSTALL_INTERFACE:imgui_impl_opengl3.h>
    ${GLLOADER_INCLUDES}
    PRIVATE
      ${CMAKE_SOURCE_DIR}/imgui)

target_link_libraries(${component}
  ${GLLOADER_LIBRARIES}
  OpenGL::GL
  OpenGL::GLX)

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
  ${CMAKE_SOURCE_DIR}/imgui/examples/imgui_impl_opengl3.h
  COMPONENT ${component}
  DESTINATION ${CMAKE_INSTALL_PREFIX}/include
)