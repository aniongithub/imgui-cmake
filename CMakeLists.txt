cmake_minimum_required(VERSION 3.0)

set(project imgui)
set(version 1.79)

project(${project})

option(BUILD_SHARED_LIBS "Build shared libs" ON)
if(NOT BUILD_SHARED_LIBS)
  set(CMAKE_POSITION_INDEPENDENT_CODE ON)
endif()

# Choose a GL loader for this build/install

set(IMGUI_GLLOADER glew CACHE STRING 
  "Choose the GL loader to use options are gl3w/glew")

set(GLLOADER_INCLUDES "")
set(GLLOADER_LIBRARIES "")

if (${IMGUI_GLLOADER} STREQUAL "gl3w")
  message(STATUS "Using GL3W...")
  set(OpenGL_GL_PREFERENCE "GLVND")
  find_package(GL3W REQUIRED)
  add_compile_definitions(IMGUI_IMPL_OPENGL_LOADER_GLEW)
  set(GLLOADER_INCLUDES ${GL3W_INCLUDE_DIRS})
  set(GLLOADER_LIBRARIES ${GL3W_LIBRARIES})
endif()

if (${IMGUI_GLLOADER} STREQUAL "glew")
  message(STATUS "Using glew...")
  find_package(GLEW REQUIRED)
  add_compile_definitions(IMGUI_IMPL_OPENGL_LOADER_GLEW)
  set(GLLOADER_INCLUDES ${GLEW_INCLUDE_DIRS})
  set(GLLOADER_LIBRARIES ${GLEW_LIBRARIES})
endif()

add_subdirectory(imgui-core)

option(IMGUI_GLFW_IMPL "Build GLFW impl" ON)
if (${IMGUI_GLFW_IMPL})
  add_subdirectory(imgui-glfw)
endif()

option(IMGUI_SDL_IMPL "Build SDL impl" ON)
if (${IMGUI_SDL_IMPL})
  add_subdirectory(imgui-sdl)
endif()

option(IMGUI_OPENGL2_IMPL "Build OpenGL2 impl" OFF)
if (${IMGUI_OPENGL2_IMPL})
  add_subdirectory(imgui-opengl2)
endif()

option(IMGUI_OPENGL3_IMPL "Build OpenGL3 impl" ON)
if (${IMGUI_OPENGL3_IMPL})
  add_subdirectory(imgui-opengl3)
endif()

option(BUILD_GLFW_OPENGL3_SAMPLE "Build GLFW + OpenGL3 example" ON)
if (${BUILD_GLFW_OPENGL3_SAMPLE})
  add_subdirectory(examples/example_glfw_opengl3)
endif()

option(BUILD_SDL2_OPENGL3_SAMPLE "Build SDL2 + OpenGL3 example" ON)
if (${BUILD_SDL2_OPENGL3_SAMPLE})
  add_subdirectory(examples/example_sdl_opengl3)
endif()

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