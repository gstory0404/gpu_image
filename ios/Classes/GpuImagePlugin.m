#import "GpuImagePlugin.h"
#if __has_include(<gpu_image/gpu_image-Swift.h>)
#import <gpu_image/gpu_image-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "gpu_image-Swift.h"
#endif

@implementation GpuImagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGpuImagePlugin registerWithRegistrar:registrar];
}
@end
