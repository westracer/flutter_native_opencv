
import 'dart:async';

import 'package:flutter/services.dart';

class NativeOpencvWindows {
  static const MethodChannel _channel = MethodChannel('native_opencv_windows');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
