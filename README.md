# flutter_native_opencv
Using OpenCV natively in C++ in a Flutter app with Dart FFI. Tested with Flutter 2.5.2.

Read the full article here: https://medium.com/flutter-community/integrating-c-library-in-a-flutter-app-using-dart-ffi-38a15e16bc14

# How to build & run

## Android and iOS

Run `init.sh` script from a `scripts` folder or do the following steps manually:

1. Download OpenCV for Android and iOS: https://opencv.org/releases/
2. Copy or create symlinks:
   - `opencv2.framework` to `native_opencv/ios`
   - `OpenCV-android-sdk/sdk/native/jni/include` to `native_opencv`
   - Contents of `OpenCV-android-sdk/sdk/native/libs/**` to `native_opencv/android/src/main/jniLibs/**`

## Windows

Run `init_windows.ps1` PowerShell script from a `scripts` folder or do the following steps manually:

1. Download OpenCV for Windows: https://opencv.org/releases/
2. Unpack it. Set env. variable `OpenCV_DIR` to unpacked `...\opencv\build` folder
3. Create a hard link from `native_opencv\ios\Classes\native_opencv.cpp` to `native_opencv_windows\windows\native_opencv.cpp`
4. Make sure `native_opencv_windows\windows\CMakeLists.txt` contains correct .dll names (OpenCV_DEBUG_DLL_NAME,OpenCV_RELEASE_DLL_NAME)

## macOS

Before doing anything else, you need to download OpenCV source code and 
build a framework by running `opencv/platforms/apple/build_xcframework.py` script.

Run `init_macos.sh` script from a `scripts` folder or do the following steps manually:

1. Download OpenCV source code: https://opencv.org/releases/
2. Unpack it. Build a framework by running opencv/platforms/apple/build_xcframework.py
3. Create a hard link from `native_opencv/ios/Classes/native_opencv.cpp` to `native_opencv_macos/macos/Classes/native_opencv.cpp`
4. Copy `opencv2.xcframework` to `native_opencv/macos`

## Linux

Before doing anything else, you need to download OpenCV source code and
build libraries by following [the official tutorial](https://docs.opencv.org/master/d7/d9f/tutorial_linux_install.html).

After making a build, set up an environmental variable `OpenCV_DIR` to the build's folder.

Run `init_linux.sh` script from a `scripts` folder or do the following steps manually:

1. Create a hard link from `native_opencv/ios/Classes/native_opencv.cpp` to `native_opencv_linux/linux/native_opencv.cpp`

# Troubleshooting

```
  /snap/flutter/current/usr/include/x86_64-linux-gnu/gnu/stubs.h:7:11: fatal error: 'gnu/stubs-32.h' file not found
  # include <gnu/stubs-32.h>
            ^~~~~~~~~~~~~~~~
  1 error generated.
  ninja: build stopped: subcommand failed.
```
or
```
/snap/flutter/current/usr/bin/ld: warning: /usr/lib/gcc/x86_64-linux-gnu/11/../../../x86_64-linux-gnu/crt1.o: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0008002
clang: error: linker command failed with exit code 1 (use -v to see invocation)
Exception: Build process failed
```

Install flutter manually instead of from snap, see: https://flutter.dev/docs/get-started/install/linux#install-flutter-manually