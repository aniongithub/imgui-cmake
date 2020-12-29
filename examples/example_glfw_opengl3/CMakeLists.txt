cmake_minimum_required(VERSION 2.8.12)

project(imgui_opengl3_example)

set(OpenGL_GL_PREFERENCE "GLVND")
find_package(OpenGL REQUIRED)

find_package(imgui QUIET COMPONENTS imgui-core imgui-glfw imgui-opengl3)
find_package(glfw3 REQUIRED CONFIG)

find_package(GLEW REQUIRED)

set(srcs /workspaces/imgui-cmake/imgui/examples/example_glfw_opengl3/main.cpp)
add_executable(imgui_opengl3_example ${srcs})

target_include_directories(imgui_opengl3_example PRIVATE
    ${OPENGL_INCLUDE_DIR}
    imgui)

target_link_libraries(imgui_opengl3_example
        ${CMAKE_DL_LIBS}
        glfw
        imgui-core
        imgui-glfw
        imgui-opengl3
        GLEW::glew
        OpenGL::GL
        OpenGL::GLX)

install(TARGETS imgui_opengl3_example DESTINATION bin)