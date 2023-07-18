cmake_minimum_required(VERSION 2.8.12)

project(example_sdl2_opengl3)

set(OpenGL_GL_PREFERENCE "GLVND")
find_package(OpenGL REQUIRED)

find_package(imgui QUIET COMPONENTS imgui-core imgui-sdl imgui-opengl3)
find_package(SDL2 REQUIRED CONFIG)

set(srcs 
    ${CMAKE_SOURCE_DIR}/imgui/examples/${PROJECT_NAME}/main.cpp)
add_executable(${PROJECT_NAME} ${srcs})

target_include_directories(${PROJECT_NAME} PRIVATE
    ${OPENGL_INCLUDE_DIR}
    ${SDL2_INCLUDE_DIRS}
    imgui)

target_link_libraries(${PROJECT_NAME}
        ${CMAKE_DL_LIBS}
        ${SDL2_LIBRARIES}
        imgui-core
        imgui-sdl
        imgui-opengl3
        OpenGL::GL
        OpenGL::GLX)

install(TARGETS ${PROJECT_NAME} DESTINATION bin)