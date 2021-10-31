cmake_minimum_required(VERSION 3.15)
set(PROJECT_NAME "native_opencv_windows")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "native_opencv_windows_plugin")

set(OpenCV_RELEASE_DLL_NAME "opencv_world454.dll")
set(OpenCV_DEBUG_DLL_NAME "opencv_world454d.dll")

add_library(${PLUGIN_NAME} SHARED
  "native_opencv_windows_plugin.cpp"
  "native_opencv.cpp"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")

target_compile_definitions(${PLUGIN_NAME} PRIVATE
  OpenCV_DLL_NAME=
  $<$<CONFIG:Debug>:${OpenCV_DEBUG_DLL_NAME}>
  $<$<CONFIG:Profile>:${OpenCV_RELEASE_DLL_NAME}>
  $<$<CONFIG:Release>:${OpenCV_RELEASE_DLL_NAME}>
)

set("OpenCV_DIR" $ENV{OpenCV_DIR})
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

target_link_libraries(${PLUGIN_NAME} PRIVATE ${OpenCV_LIBS} flutter flutter_wrapper_plugin)

# List of absolute paths to libraries that should be bundled with the plugin
set(native_opencv_windows_bundled_libraries
  ""
  "${_OpenCV_LIB_PATH}/${OpenCV_DLL_NAME}"
  PARENT_SCOPE
)
