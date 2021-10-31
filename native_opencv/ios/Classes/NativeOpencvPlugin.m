#import "NativeOpencvPlugin.h"
#if __has_include(<native_opencv/native_opencv-Swift.h>)
#import <native_opencv/native_opencv-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_opencv-Swift.h"
#endif

@implementation NativeOpencvPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeOpencvPlugin registerWithRegistrar:registrar];
}
@end
