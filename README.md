# flutter_native_opencv
Using OpenCV natively in C++ in a Flutter app with Dart FFI. Tested with Flutter 1.20.2.

Read the full article here: https://medium.com/flutter-community/integrating-c-library-in-a-flutter-app-using-dart-ffi-38a15e16bc14

# How to build & run

run

    bash init.sh

This script will:

1. Download OpenCV for Android and iOS: https://opencv.org/releases/
2. Copy or create symlinks:
   - `opencv2.framework` to `native_opencv/ios`
   - `OpenCV-android-sdk/sdk/native/jni/include` to `native_opencv`
   - Contents of `OpenCV-android-sdk/sdk/native/libs/**` to `native_opencv/android/src/main/jniLibs/**`

# Troubleshooting

```
  /snap/flutter/current/usr/include/x86_64-linux-gnu/gnu/stubs.h:7:11: fatal error: 'gnu/stubs-32.h' file not found
  # include <gnu/stubs-32.h>
            ^~~~~~~~~~~~~~~~
  1 error generated.
  ninja: build stopped: subcommand failed.
```

Install flutter manually instead of from snap, see: https://flutter.dev/docs/get-started/install/linux#install-flutter-manually