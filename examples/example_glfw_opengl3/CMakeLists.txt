cmake_minimum_required(VERSION 2.8.12)

project(example_glfw_opengl3)

set(OpenGL_GL_PREFERENCE "GLVND")
find_package(OpenGL REQUIRED)

find_package(imgui QUIET COMPONENTS imgui-core imgui-glfw imgui-opengl3)
find_package(glfw3 REQUIRED CONFIG)

set(srcs ${CMAKE_SOURCE_DIR}/imgui/examples/${PROJECT_NAME}/main.cpp)
add_executable(${PROJECT_NAME} ${srcs})

target_include_directories(${PROJECT_NAME} PRIVATE
    ${OPENGL_INCLUDE_DIR}
    imgui)

target_link_libraries(${PROJECT_NAME}
        ${CMAKE_DL_LIBS}
        glfw
        imgui-core
        imgui-glfw
        imgui-opengl3
        OpenGL::GL
        OpenGL::GLX)

install(TARGETS ${PROJECT_NAME} DESTINATION bin)