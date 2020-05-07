import Flutter
import UIKit
import PixelSDK


public class SwiftDatagrandflutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "datagrandflutter", binaryMessenger: registrar.messenger())
    let instance = SwiftDatagrandflutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "init":
            handleInitDatagrand(call: call, result: result)
            result(nil)
        case "logEvent":
            handleLogEventDatagrand(call: call, result: result)
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
  }

        private func handleInitDatagrand(call: FlutterMethodCall, result: FlutterResult) {
            let arguments: Dictionary<String, Any> = call.arguments as! Dictionary
            let appId: String = arguments["appId"] as! String
            Tracker.shared.setAPIKey(appId, addGeo: true, sendBatch: 10)
        }

        private func handleLogEventDatagrand(call: FlutterMethodCall, result: FlutterResult) {
            let arguments: Dictionary<String, Any> = call.arguments as! Dictionary
            let eventName: String = arguments["name"] as! String
            Tracker.shared.trackCustom(category: "User Interaction",
                                       action: eventName,
                                       lable: "Juan Valdez Amigos",
                                       controller: UIViewController(),
                                       addGeo: true)

        }

}
