cmake_minimum_required(VERSION 3.10)
set(PROJECT_NAME "native_opencv_linux")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "native_opencv_linux_plugin")

add_library(${PLUGIN_NAME} SHARED
  "native_opencv_linux_plugin.cc"
  "native_opencv.cpp"
)

set("OpenCV_DIR" $ENV{OpenCV_DIR})
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter)
target_link_libraries(${PLUGIN_NAME} PRIVATE PkgConfig::GTK)
target_link_libraries(${PLUGIN_NAME} PRIVATE ${OpenCV_LIBS})

# List of absolute paths to libraries that should be bundled with the plugin
set(native_opencv_linux_bundled_libraries
  ""
  PARENT_SCOPE
)
