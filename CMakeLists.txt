cmake_minimum_required(VERSION 3.0)

set(project imgui)
set(version 1.79)

project(${project})

option(BUILD_SHARED_LIBS "Build shared libs" ON)

# TODO: Add options to include these components/directories
add_subdirectory(imgui-core)
add_subdirectory(imgui-glfw)
add_subdirectory(imgui-opengl2)
add_subdirectory(imgui-opengl3)

add_subdirectory(examples/example_glfw_opengl3)

configure_file(${project}-config.cmake
  "${CMAKE_BINARY_DIR}/${project}-config.cmake"
  @ONLY
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_BINARY_DIR}/${project}-config-version.cmake"
  VERSION ${version}
  COMPATIBILITY AnyNewerVersion
)

install(
  FILES
    "${CMAKE_BINARY_DIR}/${project}-config.cmake"
  DESTINATION lib/cmake/${project}
)