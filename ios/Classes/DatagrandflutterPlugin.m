#import "DatagrandflutterPlugin.h"

#if __has_include(<datagrandflutter/datagrandflutter-Swift.h>)
#import <datagrandflutter/datagrandflutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "datagrandflutter-Swift.h"
#endif

@implementation DatagrandflutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDatagrandflutterPlugin registerWithRegistrar:registrar];
}
@end
