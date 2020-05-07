package com.paymentez.datagrandflutter

import android.app.Activity
import android.app.PendingIntent.getActivity
import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.datagran.sdk.android.pixel.Tracker
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding


/** DatagrandflutterPlugin */
public class DatagrandflutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "datagrandflutter")
    context = flutterPluginBinding.applicationContext;
    channel.setMethodCallHandler(this);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    private lateinit var context: Context
    private lateinit var activity: Activity

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "datagrandflutter")
      context = registrar.context()
      channel.setMethodCallHandler(DatagrandflutterPlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "init" -> handleInit(call, result)
      "logEvent" -> handleLogEvent(call, result)
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      else -> result.notImplemented()
    }
  }

  private fun handleInit(call: MethodCall, result: MethodChannel.Result) {
    val arguments = call.arguments as Map<*, *>
    val appId = arguments["appId"] as String?
    Tracker.init(context, true, appId, 1)
    Tracker.singleton().setActivityContext(activity)
    result.success(null)
  }

  private fun handleLogEvent(call: MethodCall, result: MethodChannel.Result) {
    val arguments = call.arguments as Map<*, *>
    val eventName = arguments["name"] as String?
    Tracker.singleton().trackCustom("User Interaction", "Juan Valdez Amigos", eventName, context, true)
    result.success(null)
  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
    activity = p0.activity
  }

  override fun onAttachedToActivity(p0: ActivityPluginBinding) {
    activity = p0.activity
  }
}
