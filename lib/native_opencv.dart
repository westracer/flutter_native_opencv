import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:ffi/ffi.dart';

// C function signatures
typedef _version_func = ffi.Pointer<Utf8> Function();
typedef _process_image_func = ffi.Void Function(ffi.Pointer<Utf8>, ffi.Pointer<Utf8>);

// Dart function signatures
typedef _VersionFunc = ffi.Pointer<Utf8> Function();
typedef _ProcessImageFunc = void Function(ffi.Pointer<Utf8>, ffi.Pointer<Utf8>);

// Getting a library that holds needed symbols
ffi.DynamicLibrary _lib = Platform.isAndroid
  ? ffi.DynamicLibrary.open('libnative_opencv.so')
  : ffi.DynamicLibrary.process();

// Looking for the functions
final _VersionFunc _version = _lib
  .lookup<ffi.NativeFunction<_version_func>>('version')
  .asFunction();
final _ProcessImageFunc _processImage = _lib
  .lookup<ffi.NativeFunction<_process_image_func>>('process_image')
  .asFunction();

String opencvVersion() {
  return Utf8.fromUtf8(_version());
}

void processImage(ProcessImageArguments args) {
  _processImage(Utf8.toUtf8(args.inputPath), Utf8.toUtf8(args.outputPath));
}

class ProcessImageArguments {
  final String inputPath;
  final String outputPath;

  ProcessImageArguments(this.inputPath, this.outputPath);
}