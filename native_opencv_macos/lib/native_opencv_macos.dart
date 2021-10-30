
import 'dart:async';

import 'package:flutter/services.dart';

class NativeOpencvMacos {
  static const MethodChannel _channel = MethodChannel('native_opencv_macos');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
