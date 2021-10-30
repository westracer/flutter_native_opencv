
import 'dart:async';

import 'package:flutter/services.dart';

class NativeOpencvLinux {
  static const MethodChannel _channel = MethodChannel('native_opencv_linux');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
