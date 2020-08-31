# flutter_native_opencv
Using OpenCV natively in C++ in a Flutter app with Dart FFI. Tested with Flutter 1.20.2.

Read the full article here: [https://medium.com/flutter-community/integrating-c-library-in-a-flutter-app-using-dart-ffi-38a15e16bc14]()

# How to build & run
1. Download OpenCV for Android and iOS: https://opencv.org/releases/
2. Copy or create symlinks:
   - *opencv2.framework* to *native_opencv/ios*
   - *OpenCV-android-sdk/sdk/native/jni/include* to *native_opencv*
   - Contents of _OpenCV-android-sdk/sdk/native/jni/libs/**_ to *native_opencv/android/src/main/jniLibs*
