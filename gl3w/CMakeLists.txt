set(component gl3w)

set(srcs
  ${CMAKE_SOURCE_DIR}/imgui/examples/libs/gl3w/GL/gl3w.c)
add_library(${component} ${srcs})

# namespaced alias
add_library(${project}::${component} ALIAS ${component})

target_include_directories(${component}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/imgui/examples/libs/gl3w>
    $<INSTALL_INTERFACE:GL>
)

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
    ${CMAKE_SOURCE_DIR}/imgui/examples/libs/gl3w/GL/gl3w.h
    ${CMAKE_SOURCE_DIR}/imgui/examples/libs/gl3w/GL/glcorearb.h
  COMPONENT ${component}
  DESTINATION ${CMAKE_INSTALL_PREFIX}/include/GL
)