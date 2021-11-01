echo "Enter path to the opencv2.xcframework framework: "  
read path_to_framework
ln ../native_opencv/ios/Classes/native_opencv.cpp ../native_opencv_macos/macos/Classes/native_opencv.cpp
cp -r $path_to_framework ../native_opencv_macos/macos

echo "Done"