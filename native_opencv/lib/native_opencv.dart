import 'dart:async';

import 'package:flutter/services.dart';

class NativeOpencv {
  static const MethodChannel _channel =
      const MethodChannel('native_opencv');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
