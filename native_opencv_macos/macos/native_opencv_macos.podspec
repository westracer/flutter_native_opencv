#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint native_opencv_macos.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'native_opencv_macos'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'

  # telling CocoaPods not to remove framework
  s.preserve_paths = 'opencv2.xcframework' 

  # telling linker to include opencv2 framework
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework opencv2' }

  # including OpenCV framework
  s.vendored_frameworks = 'opencv2.xcframework' 

  # including native framework
  s.frameworks = 'AVFoundation', 'Accelerate', 'OpenCL'

  # including C++ library
  s.library = 'c++'
end
