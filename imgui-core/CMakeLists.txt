set(component imgui-core)

add_library(${component} 
  ${CMAKE_SOURCE_DIR}/imgui/imgui.cpp
  ${CMAKE_SOURCE_DIR}/imgui/imgui_draw.cpp
  ${CMAKE_SOURCE_DIR}/imgui/imgui_widgets.cpp
  ${CMAKE_SOURCE_DIR}/imgui/imgui_demo.cpp
  )

# namespaced alias
add_library(${project}::${component} ALIAS ${component})

target_include_directories(${component}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/imgui>
    $<INSTALL_INTERFACE:imgui.h>
    $<INSTALL_INTERFACE:imgui_internal.h>
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
    ${CMAKE_SOURCE_DIR}/imgui/imgui.h
    ${CMAKE_SOURCE_DIR}/imgui/imgui_internal.h
    ${CMAKE_SOURCE_DIR}/imgui/imconfig.h
    ${CMAKE_SOURCE_DIR}/imgui/imstb_rectpack.h
    ${CMAKE_SOURCE_DIR}/imgui/imstb_textedit.h
    ${CMAKE_SOURCE_DIR}/imgui/imstb_truetype.h
  COMPONENT ${component}
  DESTINATION ${CMAKE_INSTALL_PREFIX}/include
)